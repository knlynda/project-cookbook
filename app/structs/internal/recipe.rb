# frozen_string_literal: true

module Internal
  class Recipe < ::Dry::Struct
    attribute :id,          ::Types::NonEmptyString
    attribute :title,       ::Types::NonEmptyString
    attribute :description, ::Types::NonEmptyString
    attribute :image_url,   ::Types::NonEmptyString
    attribute :chef_name,   ::Types::NonEmptyString.optional
    attribute :tags,        ::Types::ArrayOfStringsEmptyByDefault
  end
end
