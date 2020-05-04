# frozen_string_literal: true

module DataHelper
  class << self
    def contentful_recipes_response(key)
      JSON.parse(File.read(File.join(__dir__, 'contentful', "#{key}_response.json")))
    end

    def contentful_recipes_struct_dump(key)
      JSON.parse(File.read(File.join(__dir__, 'contentful', "#{key}_struct_dump.json"))).deep_symbolize_keys
    end
  end
end
