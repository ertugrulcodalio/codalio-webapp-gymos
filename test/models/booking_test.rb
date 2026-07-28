# frozen_string_literal: true

require "test_helper"

class BookingTest < ActiveSupport::TestCase
  setup do
    @organization = create(:organization)
    @user = create(:user)
    @trainer = create(:trainer, organization: @organization)
    @gym_class = create(:gym_class, organization: @organization, trainer: @trainer, capacity: 2, start_time: Time.current + 1.hour, end_time: Time.current + 2.hours)
  end

  test "should be valid with remaining capacity" do
    booking = build(:booking, user: @user, organization: @organization, gym_class: @gym_class, status: "Confirmed")
    assert booking.valid?
  end

  test "should be invalid if class is at full capacity" do
    create(:booking, user: create(:user), organization: @organization, gym_class: @gym_class, status: "Confirmed")
    create(:booking, user: create(:user), organization: @organization, gym_class: @gym_class, status: "Confirmed")

    booking = build(:booking, user: @user, organization: @organization, gym_class: @gym_class, status: "Confirmed")
    assert_not booking.valid?
    assert_includes booking.errors[:base], "Class is already at full capacity"
  end
end
