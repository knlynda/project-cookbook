# frozen_string_literal: true

module Contentful
  class RecipesFactory
    def call(parsed_response)
      ::Contentful::Recipes.new(
        total:   parsed_response['total'],
        skip:    parsed_response['skip'],
        limit:   parsed_response['limit'],
        items: build_items_attributes(
          parsed_response.fetch('items', []),
          parsed_response.fetch('includes', [])
        )
      )
    end

    private

    IMAGE_RESIZE_PARAMS = {
      small: {
        fit: 'fill',
        w:   64,
        h:   48
      },
      big: {
        fit: 'fill',
        w:   320,
        h:   240
      }
    }.freeze
    private_constant :IMAGE_RESIZE_PARAMS

    def build_items_attributes(items, includes)
      items.map do |item|
        {
          id:          item.dig('sys', 'id'),
          title:       item.dig('fields', 'title'),
          description: item.dig('fields', 'description'),
          photo:       build_photo_attributes(item.dig('fields', 'photo'), includes),
          chef:        build_chef_attributes(item.dig('fields', 'chef'), includes),
          tags:        build_tags_attributes(item.dig('fields', 'tags'), includes)
        }
      end
    end

    def build_photo_attributes(photo_link, includes)
      return if photo_link.blank?

      photo = find_included_data(photo_link, includes)

      {
        id:             photo.dig('sys', 'id'),
        title:          photo.dig('fields', 'title'),
        file_name:      photo.dig('fields', 'file', 'fileName'),
        content_type:   photo.dig('fields', 'file', 'contentType'),
        file_url:       photo.dig('fields', 'file', 'url'),
        small_file_url: build_image_url(:small, photo.dig('fields', 'file', 'url')),
        big_file_url:   build_image_url(:big, photo.dig('fields', 'file', 'url'))
      }
    end

    def build_image_url(size, image_url)
      ::URI.parse(image_url).tap { |url| url.query = IMAGE_RESIZE_PARAMS.fetch(size).to_param }.to_s
    end

    def build_chef_attributes(chef_link, includes)
      return if chef_link.blank?

      chef = find_included_data(chef_link, includes)

      {
        id:   chef.dig('sys', 'id'),
        name: chef.dig('fields', 'name')
      }
    end

    def build_tags_attributes(tag_links, includes)
      return [] if tag_links.blank?

      tag_links.map do |tag_link|
        tag = find_included_data(tag_link, includes)

        {
          id:   tag.dig('sys', 'id'),
          name: tag.dig('fields', 'name')
        }
      end
    end

    def find_included_data(value, includes)
      item_id = value.dig('sys', 'id')
      item_type = value.dig('sys', 'linkType')
      includes
        .fetch(item_type, [])
        .find { |inc| inc.dig('sys', 'id') == item_id }
    end
  end
end
