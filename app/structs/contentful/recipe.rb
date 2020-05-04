# frozen_string_literal: true

module Contentful
  class Recipe < ::Dry::Struct
    attribute :id,          ::Types::NonEmptyString
    attribute :title,       ::Types::NonEmptyString
    attribute :description, ::Types::NonEmptyString
    attribute :photo,       ::Contentful::Photo.optional
    attribute :chef,        ::Contentful::Chef.optional
    attribute :tags,        ::Types::ArrayEmptyByDefault.of(::Contentful::Chef)
  end
end
