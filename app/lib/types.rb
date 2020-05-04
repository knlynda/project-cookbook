# frozen_string_literal: true

module Types
  include ::Dry.Types()

  EMPTY_ARRAY = [].freeze

  NonEmptyString =               ::Types::Strict::String.constrained(min_size: 1)
  NonNegativeInteger =           ::Types::Strict::Integer.constrained(gteq: 0)
  ArrayEmptyByDefault =          ::Types::Strict::Array.default(EMPTY_ARRAY)
  ArrayOfStringsEmptyByDefault = ::Types::ArrayEmptyByDefault.of(::Types::Strict::String)
end
