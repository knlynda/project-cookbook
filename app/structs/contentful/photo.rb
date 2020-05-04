# frozen_string_literal: true

module Contentful
  class Photo < ::Dry::Struct
    attribute :id,             ::Types::NonEmptyString
    attribute :title,          ::Types::NonEmptyString
    attribute :file_name,      ::Types::NonEmptyString
    attribute :file_url,       ::Types::NonEmptyString
    attribute :small_file_url, ::Types::NonEmptyString
    attribute :big_file_url,   ::Types::NonEmptyString
    attribute :content_type,   ::Types::NonEmptyString
  end
end
