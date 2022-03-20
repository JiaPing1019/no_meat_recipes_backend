# frozen_string_literal: true

require 'spec_helper'

describe Recipe do
  let(:category) { create(:category, name: 'Vegetarian Mushroom Side Dishes') }

  describe 'validation' do
    subject { described_class.new(params) }

    context 'when valid' do
      let(:params) { { category: category, title: 'Crock-Pot® Mushrooms' } }

      it 'returns valid is true' do
        expect(subject.valid?).to eq(true)
      end
    end

    context 'when title is null' do
      let(:params) { { category: category } }

      it 'returns valid is false' do
        expect(subject.valid?).to eq(false)
      end
    end

    context 'when catogory is null' do
      let(:params) { { title: 'Crock-Pot® Mushrooms' } }

      it 'returns valid is false' do
        expect(described_class.new.save).to eq(false)
      end
    end
  end
end
