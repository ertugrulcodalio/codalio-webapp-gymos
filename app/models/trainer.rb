# frozen_string_literal: true

class Trainer < ApplicationRecord
  belongs_to :organization
  has_many :gym_classes, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true

  rhino_owner :organization
  rhino_references [ :organization ]
end
