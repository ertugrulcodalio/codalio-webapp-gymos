# frozen_string_literal: true

class MemberProfile < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  belongs_to :membership_plan

  validates :status, presence: true

  rhino_owner :organization
  rhino_references [ :organization, :user, :membership_plan ]
end
