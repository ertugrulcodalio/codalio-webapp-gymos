# frozen_string_literal: true

require "test_helper"

class MembershipPlanTest < ActiveSupport::TestCase
  setup do
    @organization = create(:organization)
    @plan = create(:membership_plan, organization: @organization)
  end

  test "should be deletable if no active subscriptions" do
    assert @plan.destroy
  end

  test "should not be deletable if there are active subscriptions" do
    user = create(:user)
    create(:member_profile, organization: @organization, membership_plan: @plan, status: "Active", user: user)
    assert_not @plan.destroy
    assert_includes @plan.errors[:base], "Cannot delete plan with active subscriptions"
  end
end
