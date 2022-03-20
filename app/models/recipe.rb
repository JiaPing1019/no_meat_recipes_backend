# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :category
  has_many :ingredients, dependent: :destroy

  validates :title, presence: true
end
