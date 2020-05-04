# frozen_string_literal: true

::Dry::Rails.container do
  register('contentful_recipes_factory') { ::Contentful::RecipesFactory.new }
  register('http_repository')            { ::HttpRepository.new(logger: Rails.logger) }

  register('contentful_repository') do
    ::ContentfulRepository.new(
      api_url:     ENV.fetch('CONTENTFUL_API_URL'),
      space:       ENV.fetch('CONTENTFUL_SPACE'),
      environment: ENV.fetch('CONTENTFUL_ENV'),
      auth_token:  ENV.fetch('CONTENTFUL_AUTH_TOKEN')
    )
  end
end
