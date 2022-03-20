# frozen_string_literal: true

describe Ingredient do
  let(:category) { Category.create(name: 'Vegetarian Mushroom Side Dishes') }
  let(:recipe) { category.recipes.create(title: 'Vegetarian Mushroom Side Dishes') }

  describe 'validation' do
    subject { described_class.new(params) }

    context 'when valid' do
      let(:params) { { name: '1 pound mushrooms', recipe: recipe } }

      it 'returns valid is true' do
        expect(subject.valid?).to eq(true)
      end
    end

    context 'when name is null' do
      let(:params) { { recipe: recipe } }

      it 'returns valid is false' do
        expect(subject.valid?).to eq(false)
      end
    end

    context 'when recipe is null' do
      let(:params) { { name: '1 pound mushrooms' } }

      it 'returns valid is false' do
        expect(subject.valid?).to eq(false)
      end
    end
  end
end
