# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { "9.99" }
    plan_name { "MyString" }
    status { "MyString" }
    organization { nil }
    user { nil }
  end
end
