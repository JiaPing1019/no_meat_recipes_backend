# frozen_string_literal: true

describe V1::RecipeSerializer do
  describe '#initialize' do
    before do
      category = create(:category, name: 'Vegetarian Mushroom Side Dishes')
      @recipe = create(:recipe, category: category)
      create(:ingredient, recipe: @recipe, name: '½ cup vegetable broth')
      create(:ingredient, recipe: @recipe, name: '1 ½ teaspoons brown sugar')
    end

    it 'renders correctly' do
      result = described_class.new(@recipe).as_json
      result_of_ingredients = @recipe.ingredients.map { |ingredient| { name: ingredient.name } }

      expect(result).to eq({
        recipeId: @recipe.id,
        catogory_name: @recipe.category.name,
        title: @recipe.title,
        cook_time: @recipe.cook_time,
        prep_time: @recipe.prep_time,
        ratings: @recipe.ratings,
        cuisine: @recipe.cuisine,
        author: @recipe.author,
        image_url: @recipe.image_url,
        created_at: @recipe.created_at,
        updated_at: @recipe.updated_at,
        ingredients: result_of_ingredients
      })
    end
  end
end
