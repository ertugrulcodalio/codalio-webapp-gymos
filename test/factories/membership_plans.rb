# frozen_string_literal: true

FactoryBot.define do
  factory :membership_plan do
    name { "MyString" }
    price { 1.5 }
    status { "MyString" }
    weekly_class_limit { 1 }
    organization { nil }
  end
end
