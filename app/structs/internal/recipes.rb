# frozen_string_literal: true

module Internal
  class Recipes < ::Dry::Struct
    attribute :total, ::Types::NonNegativeInteger
    attribute :skip,  ::Types::NonNegativeInteger
    attribute :limit, ::Types::NonNegativeInteger

    attribute :items, ::Types::ArrayEmptyByDefault do
      attribute :id,        ::Types::NonEmptyString
      attribute :title,     ::Types::NonEmptyString
      attribute :image_url, ::Types::NonEmptyString
    end

    class << self
      def build_from_contentful_recipes(contentful_recipes)
        new(
          total: contentful_recipes.total,
          skip:  contentful_recipes.skip,
          limit: contentful_recipes.limit,
          items: build_items_attributes(contentful_recipes)
        )
      end

      private

      def build_items_attributes(contentful_recipes)
        contentful_recipes.items.map do |contentful_recipe|
          {
            id:        contentful_recipe.id,
            title:     contentful_recipe.title,
            image_url: contentful_recipe.photo.small_file_url
          }
        end
      end
    end
  end
end
