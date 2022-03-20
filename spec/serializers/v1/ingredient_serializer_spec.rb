# frozen_string_literal: true

describe V1::IngredientSerializer do
  describe '#initialize' do
    before do
      category = create(:category, name: 'Vegetarian Mushroom Side Dishes')
      recipe = create(:recipe, category: category)
      @ingredient = create(:ingredient, recipe: recipe, name: '½ cup vegetable broth')
    end

    it 'renders correctly' do
      result = described_class.new(@ingredient).as_json

      expect(result).to eq({
        name: @ingredient.name
      })
    end
  end
end
