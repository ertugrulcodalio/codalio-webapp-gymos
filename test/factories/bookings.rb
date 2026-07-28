# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    user { nil }
    status { "MyString" }
    organization { nil }
    gym_class { nil }
  end
end
