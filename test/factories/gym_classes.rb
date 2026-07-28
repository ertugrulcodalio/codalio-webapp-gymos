# frozen_string_literal: true

FactoryBot.define do
  factory :gym_class do
    name { "MyString" }
    description { "MyText" }
    start_time { "2026-07-28 20:53:36" }
    end_time { "2026-07-28 20:53:36" }
    capacity { 1 }
    status { "MyString" }
    organization { nil }
    trainer { nil }
  end
end
