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
  end
end
