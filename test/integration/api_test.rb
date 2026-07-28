# frozen_string_literal: true

require "test_helper"

class ApiTest < ActionDispatch::IntegrationTest
  setup do
    @organization = create(:organization)
    @other_organization = create(:organization, name: "Other Gym")

    @staff_user = create(:user)
    @member_user = create(:user)

    # Assign roles
    @staff_role = Role.find_or_create_by!(name: "gym_staff")
    @member_role = Role.find_or_create_by!(name: "gym_member")

    UsersRole.create!(user: @staff_user, role: @staff_role, organization: @organization)
    UsersRole.create!(user: @member_user, role: @member_role, organization: @organization)

    @staff_headers = @staff_user.create_new_auth_token
    @member_headers = @member_user.create_new_auth_token
  end

  # AC-12: Strict Data Isolation Verification
  # AC-13: Any attempt to access data belonging to another tenant ID returns an unauthorized error or a 404 Not Found
  test "AC-12, AC-13: enforces strict tenant isolation on queries" do
    trainer = create(:trainer, organization: @organization)
    other_trainer = create(:trainer, organization: @other_organization)

    get "/api/trainers", headers: @staff_headers
    assert_response :success
    
    trainer_ids = JSON.parse(response.body)["results"].map { |t| t["id"] }
    assert_includes trainer_ids, trainer.id
    assert_not_includes trainer_ids, other_trainer.id
  end

  # AC-21: Only gym_staff can access the trainer management page / endpoints
  # AC-22: Unauthenticated users are redirected or return 401/403
  test "AC-21, AC-22: trainer management permissions" do
    # Guest (unauthenticated)
    get "/api/trainers"
    assert_response :unauthorized

    # Member (unauthorized to create)
    post "/api/trainers", params: { crud: { name: "New Trainer", email: "t@gym.com", organization: { id: @organization.id } } }, headers: @member_headers
    assert_response :forbidden

    # Staff (authorized)
    post "/api/trainers", params: { crud: { name: "New Trainer", email: "t@gym.com", organization: { id: @organization.id } } }, headers: @staff_headers
    assert_response :success
  end

  # AC-26: Membership Plan Management
  test "AC-26: membership plan management permissions" do
    # Member (unauthorized to create)
    post "/api/membership_plans", params: { crud: { name: "Gold Plan", price: 99.99, status: "Active", weekly_class_limit: 5, organization: { id: @organization.id } } }, headers: @member_headers
    assert_response :forbidden

    # Staff (authorized)
    assert_difference -> { MembershipPlan.count }, 1 do
      post "/api/membership_plans", params: { crud: { name: "Gold Plan", price: 99.99, status: "Active", weekly_class_limit: 5, organization: { id: @organization.id } } }, headers: @staff_headers
    end
    assert_response :success
  end

  # AC-31: Class Scheduling & Management
  test "AC-31: class scheduling permissions" do
    trainer = create(:trainer, organization: @organization)

    # Member (unauthorized to create)
    post "/api/gym_classes", params: { crud: { name: "Yoga", trainer: { id: trainer.id }, start_time: Time.current + 1.day, end_time: Time.current + 1.day + 1.hour, capacity: 10, status: "Active", organization: { id: @organization.id } } }, headers: @member_headers
    assert_response :forbidden

    # Staff (authorized)
    post "/api/gym_classes", params: { crud: { name: "Yoga", trainer: { id: trainer.id }, start_time: Time.current + 1.day, end_time: Time.current + 1.day + 1.hour, capacity: 10, status: "Active", organization: { id: @organization.id } } }, headers: @staff_headers
    assert_response :success
  end

  # AC-36: View Member Bookings & Attendance
  test "AC-36: view member bookings and attendance" do
    trainer = create(:trainer, organization: @organization)
    gym_class = create(:gym_class, organization: @organization, trainer: trainer, start_time: Time.current + 1.day, end_time: Time.current + 1.day + 1.hour, capacity: 10, status: "Active")
    booking = create(:booking, organization: @organization, user: @member_user, gym_class: gym_class, status: "Confirmed")

    # Staff can view bookings
    get "/api/bookings", headers: @staff_headers
    assert_response :success
    booking_ids = JSON.parse(response.body)["results"].map { |b| b["id"] }
    assert_includes booking_ids, booking.id
  end

  # AC-51: Book a Class
  test "AC-51: book a class" do
    trainer = create(:trainer, organization: @organization)
    gym_class = create(:gym_class, organization: @organization, trainer: trainer, start_time: Time.current + 1.day, end_time: Time.current + 1.day + 1.hour, capacity: 10, status: "Active")
    plan = create(:membership_plan, organization: @organization, weekly_class_limit: 3)
    create(:member_profile, organization: @organization, user: @member_user, membership_plan: plan, status: "Active")

    assert_difference -> { Booking.count }, 1 do
      post "/api/bookings", params: { crud: { gym_class: { id: gym_class.id }, status: "Confirmed", user: { id: @member_user.id }, organization: { id: @organization.id } } }, headers: @member_headers
    end
    assert_response :success
  end

  # AC-61: Enforce Weekly Class Limit
  test "AC-61: enforces weekly class limit" do
    trainer = create(:trainer, organization: @organization)
    plan = create(:membership_plan, organization: @organization, weekly_class_limit: 1)
    create(:member_profile, organization: @organization, user: @member_user, membership_plan: plan, status: "Active")

    gym_class1 = create(:gym_class, organization: @organization, trainer: trainer, start_time: Time.current.beginning_of_week + 1.day, end_time: Time.current.beginning_of_week + 1.day + 1.hour, capacity: 10, status: "Active")
    gym_class2 = create(:gym_class, organization: @organization, trainer: trainer, start_time: Time.current.beginning_of_week + 2.days, end_time: Time.current.beginning_of_week + 2.days + 1.hour, capacity: 10, status: "Active")

    # First booking succeeds
    post "/api/bookings", params: { crud: { gym_class: { id: gym_class1.id }, status: "Confirmed", user: { id: @member_user.id }, organization: { id: @organization.id } } }, headers: @member_headers
    assert_response :success

    # Second booking fails due to weekly limit
    post "/api/bookings", params: { crud: { gym_class: { id: gym_class2.id }, status: "Confirmed", user: { id: @member_user.id }, organization: { id: @organization.id } } }, headers: @member_headers
    assert_response :forbidden
  end

  # AC-66: Mock Payment & Subscription Activation
  test "AC-66: mock payment and subscription activation" do
    plan = create(:membership_plan, organization: @organization)
    
    assert_difference -> { MemberProfile.count }, 1 do
      post "/api/member_profiles", params: { crud: { membership_plan: { id: plan.id }, status: "Active", user: { id: @member_user.id }, organization: { id: @organization.id } } }, headers: @member_headers
    end
    assert_response :success
  end

  # AC-71: Subscription Billing History
  test "AC-71: subscription billing history" do
    transaction = create(:transaction, organization: @organization, user: @member_user, amount: 49.99, plan_name: "Basic Plan", status: "Paid")

    get "/api/transactions", headers: @member_headers
    assert_response :success
    transaction_ids = JSON.parse(response.body)["results"].map { |t| t["id"] }
    assert_includes transaction_ids, transaction.id
  end
end
