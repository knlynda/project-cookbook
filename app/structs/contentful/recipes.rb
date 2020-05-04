# frozen_string_literal: true

module Contentful
  class Recipes < ::Dry::Struct
    attribute :total, ::Types::NonNegativeInteger
    attribute :skip,  ::Types::NonNegativeInteger
    attribute :limit, ::Types::NonNegativeInteger
    attribute :items, ::Types::ArrayEmptyByDefault.of(::Contentful::Recipe)
  end
end
