# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  belongs_to :gym_class

  validates :status, length: { maximum: 255 }, allow_nil: true

  validate :check_class_capacity, on: :create

  rhino_owner :organization
  rhino_references [ :organization, :user, :gym_class ]
  rhino_policy :booking

  private

  def check_class_capacity
    return unless gym_class

    active_bookings_count = gym_class.bookings.where.not(status: "Cancelled").count
    if active_bookings_count >= gym_class.capacity
      errors.add(:base, "Class is already at full capacity")
    end
  end
end
