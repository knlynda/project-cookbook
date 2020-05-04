# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contentful::RecipesFactory do
  let(:factory) { described_class.new }

  describe '#call' do
    subject { described_class.new.call(parsed_response) }

    context 'when parsed response has one recipe' do
      let(:parsed_response) { DataHelper.contentful_recipes_response(:one_recipe) }
      let(:expected_struct) { Contentful::Recipes.new(DataHelper.contentful_recipes_struct_dump(:one_recipe)) }

      it { is_expected.to eq(expected_struct) }
    end

    context 'when parsed response has more then one recipe' do
      let(:parsed_response) { DataHelper.contentful_recipes_response(:four_recipes) }
      let(:expected_struct) { Contentful::Recipes.new(DataHelper.contentful_recipes_struct_dump(:four_recipes)) }

      it { is_expected.to eq(expected_struct) }
    end
  end
end
