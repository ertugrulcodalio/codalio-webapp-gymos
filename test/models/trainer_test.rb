# frozen_string_literal: true

require "test_helper"

class TrainerTest < ActiveSupport::TestCase
  setup do
    @organization = create(:organization)
    @trainer = create(:trainer, organization: @organization)
  end

  test "should be deletable if no active classes" do
    assert @trainer.destroy
  end

  test "should not be deletable if there are active classes" do
    create(:gym_class, organization: @organization, trainer: @trainer, status: "Active")
    assert_not @trainer.destroy
    assert_includes @trainer.errors[:base], "Cannot delete trainer with active classes"
  end
end
