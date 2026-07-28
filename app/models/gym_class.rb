# frozen_string_literal: true

class GymClass < ApplicationRecord
  belongs_to :organization
  belongs_to :trainer
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }

  rhino_owner :organization
  rhino_references [ :organization, :trainer ]
end
