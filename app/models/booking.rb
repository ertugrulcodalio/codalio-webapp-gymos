# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  belongs_to :gym_class

  validates :status, presence: true

  rhino_owner :organization
  rhino_references [ :organization, :user, :gym_class ]
end
