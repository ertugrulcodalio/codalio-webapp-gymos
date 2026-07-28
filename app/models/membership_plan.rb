# frozen_string_literal: true

class MembershipPlan < ApplicationRecord
  belongs_to :organization
  has_many :member_profiles, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  rhino_owner :organization
  rhino_references [ :organization ]
end
