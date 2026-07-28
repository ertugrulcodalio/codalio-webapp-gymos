# frozen_string_literal: true

class MembershipPlan < ApplicationRecord
  belongs_to :organization
  has_many :member_profiles, dependent: :destroy

  validates :name, length: { maximum: 255 }, allow_nil: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :status, length: { maximum: 255 }, allow_nil: true

  before_destroy :prevent_deletion_if_active_subscriptions, prepend: true

  rhino_owner :organization
  rhino_references [ :organization ]
  rhino_policy :membership_plan

  private

  def prevent_deletion_if_active_subscriptions
    if member_profiles.where(status: "Active").exists?
      errors.add(:base, "Cannot delete plan with active subscriptions")
      throw(:abort)
    end
  end
end
