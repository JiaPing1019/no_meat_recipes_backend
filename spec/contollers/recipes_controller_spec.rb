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
      create(:recipe, category: category_curry, title: 'Vegetarian curry')
      create(:recipe, category: category_noodle, title: 'Vegan curry')
    end

    it 'returns 200' do
      get '/recipes'
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(response_body[:recipes].size).to eq(4)
    end
  end
end
