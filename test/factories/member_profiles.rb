# frozen_string_literal: true

FactoryBot.define do
  factory :member_profile do
    user { nil }
    status { "MyString" }
    organization { nil }
    membership_plan { nil }
  end
end
