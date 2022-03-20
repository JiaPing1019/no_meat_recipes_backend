# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.references :recipe, index: true, foreign_key: true
      t.string :name, null: false
    end
  end
end
