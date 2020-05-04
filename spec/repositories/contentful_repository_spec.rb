# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContentfulRepository do
  let(:repository) do
    described_class.new(
      api_url:                     'https://test.host',
      space:                       'test_space',
      environment:                 'test_env',
      auth_token:                  'test_token',
      http_repository:             http_repository,
      contentful_recipes_factory:  contentful_recipes_factory
    )
  end

  let(:http_repository) { instance_double('HttpRepository') }
  let(:contentful_recipes_factory) { instance_double('Contentful::RecipesFactory') }

  context 'when content type is recipe' do
    let(:http_url) { 'https://test.host/spaces/test_space/environments/test_env/entries' }
    let(:http_response) { instance_double('HTTParty::Response', body: '{"a":"b"}') }
    let(:http_result) { Dry::Monads.method(:Success).call(http_response) }

    before do
      expect(http_repository).to receive(:get).with(http_url, **http_options) { http_result }
      expect(contentful_recipes_factory).to receive(:call).with('a' => 'b') { factory_result }
    end

    let(:http_options) do
      {
        headers: {
          'Authorization': 'Bearer test_token'
        },
        query: {
          content_type: 'recipe',
          select:       'sys.id,fields.title,fields.description,fields.photo,fields.tags,fields.chef',
          **query_options
        }
      }
    end

    describe '#fetch_recipes' do
      subject { repository.fetch_recipes(limit: 10, skip: 0) }
      let(:query_options) { { limit: 10, skip: 0 } }
      let(:factory_result) { instance_double('Contentful::Recipes') }
      let(:struct) { instance_double('Internal::Recipes') }

      before do
        expect(Internal::Recipes).to receive(:build_from_contentful_recipes).with(factory_result) { struct }
      end

      it 'succeeds with struct' do
        is_expected.to be_success
        expect(subject.success).to eq(struct)
      end
    end

    describe '#fetch_recipe' do
      subject { repository.fetch_recipe(id: 'test_id') }
      let(:query_options) { { limit: 1, skip: 0, 'sys.id': 'test_id' } }

      context 'when entry does not exist' do
        let(:factory_result) { instance_double('Contentful::Recipes', total: 0) }
        let(:struct) { instance_double('Internal::Recipes') }

        it 'fails with message recipe_not_found_error' do
          is_expected.to be_failure
          expect(subject.failure).to eq(:recipe_not_found_error)
        end
      end

      context 'when entry exists' do
        let(:factory_result) { instance_double('Contentful::Recipes', total: 1, items: [content_item]) }
        let(:content_item) { instance_double('Internal::Recipes') }
        let(:struct) { instance_double('Internal::Recipes') }

        before do
          expect(Internal::Recipe).to receive(:build_from_contentful_recipe).with(content_item) { struct }
        end

        it 'succeeds with struct' do
          is_expected.to be_success
          expect(subject.success).to eq(struct)
        end
      end
    end
  end
end
