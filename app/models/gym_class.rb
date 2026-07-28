# frozen_string_literal: true

class GymClass < ApplicationRecord
  belongs_to :organization
  belongs_to :trainer
  has_many :bookings, dependent: :destroy

  validates :name, length: { maximum: 255 }, allow_nil: true
  validates :capacity, numericality: { greater_than: 0 }, allow_nil: true

  validate :check_trainer_availability

  rhino_owner :organization
  rhino_references [ :organization, :trainer ]
  rhino_policy :gym_class

  private

  def check_trainer_availability
    return unless trainer_id && start_time && end_time

    overlapping_classes = GymClass.where(trainer_id: trainer_id)
                                  .where("start_time < ? AND end_time > ?", end_time, start_time)
    overlapping_classes = overlapping_classes.where.not(id: id) if id.present?

    if overlapping_classes.exists?
      errors.add(:trainer, "is already scheduled for another class at this time")
    end
  end
end
