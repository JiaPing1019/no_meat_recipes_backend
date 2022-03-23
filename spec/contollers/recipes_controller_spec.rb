# frozen_string_literal: true

RSpec.describe RecipesController, type: :request do
  describe '#index' do
    before do
      category_mushroom = create(:category, name: 'Vegetarian Mushroom Side Dishes')
      category_pumpkin_soup = create(:category, name: 'Vegan Pumpkin Soup')
      category_curry = create(:category, name: 'Curry')
      category_noodle = create(:category, name: 'Noodle')

      create(:recipe, category: category_mushroom)
      create(:recipe, category: category_pumpkin_soup)
      @curry_recipe = create(:recipe, category: category_curry, title: 'Vegetarian curry')
      @noodle_recipe = create(:recipe, category: category_noodle, title: 'Vegan curry')
    end

    it 'returns 200' do
      get '/recipes'
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(response_body[:recipes].size).to eq(4)
    end

    context 'when having ingredientQuery' do
      before do
        create(:ingredient, name: '1 teaspoon curry powder', recipe: @curry_recipe)
        create(:ingredient, name: '¼ cup prepared mustard', recipe: @curry_recipe)

        create(:ingredient, name: '1 teaspoon curry powder', recipe: @noodle_recipe)
      end

      it 'return proper results' do
        get '/recipes?ingredientQuery=curry+mustard'

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:ok)
        expect(response_body[:recipes].size).to eq(1)
        expect(response_body[:recipes][0][:title]).to eq(@curry_recipe.title)
      end
    end
  end
end
