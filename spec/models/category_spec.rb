# frozen_string_literal: true

describe Category do
  describe 'validation' do
    subject { described_class.new(params) }

    context 'when valid' do
      let(:params) { { name: 'Vegetarian Mushroom Side Dishes' } }

      it 'returns valid is true' do
        expect(subject.valid?).to eq(true)
      end
    end

    context 'when name is null' do
      let(:params) { { name: nil } }

      it 'returns valid is true' do
        expect(subject.valid?).to eq(false)
      end
    end
  end
end
