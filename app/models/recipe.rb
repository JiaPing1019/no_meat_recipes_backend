# frozen_string_literal: true

class Recipe < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :ingredient_search, associated_against: {
    ingredients: [:name]
  },
  using: {
    tsearch: {
      dictionary: "english",
    }
  }

  belongs_to :category
  has_many :ingredients, dependent: :destroy

  validates :title, presence: true
end
