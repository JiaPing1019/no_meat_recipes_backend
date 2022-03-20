module V1
  class RecipeSerializer < ActiveModel::Serializer
    attribute :id, key: :recipeId
    attribute :catogory_name
    attribute :title
    attribute :cook_time
    attribute :prep_time
    attribute :ratings
    attribute :cuisine
    attribute :author
    attribute :image_url
    attribute :created_at
    attribute :updated_at

    has_many :ingredients, serializer: V1::IngredientSerializer

    def catogory_name
      object.category.name
    end
  end
end
