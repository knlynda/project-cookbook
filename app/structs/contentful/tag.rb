# frozen_string_literal: true

module Contentful
  class Tag < ::Dry::Struct
    attribute :id,   ::Types::NonEmptyString
    attribute :name, ::Types::NonEmptyString
  end
end
