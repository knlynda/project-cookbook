# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Internal::Recipe do
  describe '.build_from_contentful_recipe' do
    subject { described_class.build_from_contentful_recipe(contentful_recipe) }
    let(:contentful_recipe) { Contentful::Recipes.new(recipe_data).items.last }
    let(:recipe_data) { DataHelper.contentful_recipes_struct_dump(:one_recipe) }

    it { is_expected.to be_a(described_class) }
  end
end
