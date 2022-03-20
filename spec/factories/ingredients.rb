# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    association :recipe
    name { '1 pound mushrooms' }
  end
end
