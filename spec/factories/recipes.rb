# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    association :category
    title { 'Crock-Pot® Mushrooms' }
  end
end
