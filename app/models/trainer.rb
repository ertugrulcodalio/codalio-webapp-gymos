# frozen_string_literal: true

class Trainer < ApplicationRecord
  belongs_to :organization
  has_many :gym_classes, dependent: :destroy

  validates :name, length: { maximum: 255 }, allow_nil: true
  validates :email, length: { maximum: 255 }, allow_nil: true

  before_destroy :prevent_deletion_if_active_classes, prepend: true

  rhino_owner :organization
  rhino_references [ :organization ]
  rhino_policy :trainer

  private

  def prevent_deletion_if_active_classes
    if gym_classes.where(status: "Active").exists?
      errors.add(:base, "Cannot delete trainer with active classes")
      throw(:abort)
    end
  end
end
