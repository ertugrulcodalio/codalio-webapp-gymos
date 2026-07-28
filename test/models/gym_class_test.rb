# frozen_string_literal: true

require "test_helper"

class GymClassTest < ActiveSupport::TestCase
  setup do
    @organization = create(:organization)
    @trainer = create(:trainer, organization: @organization)
  end

  test "should be valid if trainer is available" do
    gym_class = build(:gym_class, organization: @organization, trainer: @trainer, start_time: Time.current + 1.hour, end_time: Time.current + 2.hours)
    assert gym_class.valid?
  end

  test "should be invalid if trainer is already scheduled for another class at the same time" do
    create(:gym_class, organization: @organization, trainer: @trainer, start_time: Time.current + 1.hour, end_time: Time.current + 2.hours)

    gym_class = build(:gym_class, organization: @organization, trainer: @trainer, start_time: Time.current + 1.hour, end_time: Time.current + 2.hours)
    assert_not gym_class.valid?
    assert_includes gym_class.errors[:trainer], "is already scheduled for another class at this time"
  end
end
