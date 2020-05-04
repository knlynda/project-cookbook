# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Internal::Recipes do
  describe '.build_from_contentful_recipes' do
    subject { described_class.build_from_contentful_recipes(contentful_recipes) }

    context 'when contentful recipes has one item' do
      let(:contentful_recipes) { Contentful::Recipes.new(DataHelper.contentful_recipes_struct_dump(:one_recipe)) }

      it { is_expected.to be_a(described_class) }
    end

    context 'when contentful recipes has more then one item' do
      let(:contentful_recipes) { Contentful::Recipes.new(DataHelper.contentful_recipes_struct_dump(:four_recipes)) }

      it { is_expected.to be_a(described_class) }
    end
  end
end
