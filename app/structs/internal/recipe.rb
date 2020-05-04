# frozen_string_literal: true

module Internal
  class Recipe < ::Dry::Struct
    attribute :id,          ::Types::NonEmptyString
    attribute :title,       ::Types::NonEmptyString
    attribute :description, ::Types::NonEmptyString
    attribute :image_url,   ::Types::NonEmptyString
    attribute :chef_name,   ::Types::NonEmptyString.optional
    attribute :tags,        ::Types::ArrayOfStringsEmptyByDefault

    class << self
      def build_from_contentful_recipe(contentful_recipe)
        new(
          id:          contentful_recipe.id,
          title:       contentful_recipe.title,
          description: contentful_recipe.description,
          image_url:   contentful_recipe.photo.big_file_url,
          chef_name:   contentful_recipe.chef&.name,
          tags:        contentful_recipe.tags.pluck(:name)
        )
      end
    end
  end
end
