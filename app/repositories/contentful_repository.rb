# frozen_string_literal: true

class ContentfulRepository
  include ::Dry::Monads[:result]
  include ::ProjectCookbook::Import[
    :api_url,
    :space,
    :environment,
    :auth_token,
    :http_repository,
    :contentful_recipes_factory
  ]

  def request_recipes(limit:, skip:, conditions: {})
    options = build_recipes_request_options(limit: limit, skip: skip, conditions: conditions)

    http_repository.get(entities_url, **options).bind do |response|
      parsed_response = ::JSON.parse(response.body)
      Success(contentful_recipes_factory.call(parsed_response))
    end
  end

  private

  def entities_url
    @entities_url ||= "#{api_url}/spaces/#{space}/environments/#{environment}/entries"
  end

  def build_recipes_request_options(limit:, skip:, conditions:)
    {
      headers: {
        'Authorization': "Bearer #{auth_token}"
      },
      query: {
        content_type: 'recipe',
        select:       'sys.id,fields.title,fields.description,fields.photo,fields.tags,fields.chef',
        limit:        limit,
        skip:         skip,
        **conditions
      }
    }
  end
end
