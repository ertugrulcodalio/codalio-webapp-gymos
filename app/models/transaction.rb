# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  rhino_owner :organization
  rhino_references [ :organization, :user ]
  rhino_policy :transaction



  validates :amount, numericality: true, allow_nil: true
  validates :plan_name, length: { maximum: 255 }, allow_nil: true
  validates :status, length: { maximum: 255 }, allow_nil: true
end
