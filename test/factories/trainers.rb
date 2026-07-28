# frozen_string_literal: true

FactoryBot.define do
  factory :trainer do
    name { "MyString" }
    bio { "MyText" }
    email { "MyString" }
    organization { nil }
  end
end
