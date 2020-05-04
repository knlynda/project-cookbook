# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:page) { Nokogiri::HTML(response.body) }

  describe 'index' do
    context 'when contentful responses with recipes' do
      it 'shows recipes' do
        VCR.use_cassette('contentful/recipes_success') do
          get root_path
          expect(response).to render_template(:index)
          expect(page.css('.list-item .title').count).to eq(4)
          expect(page.css('.list-item .image').count).to eq(4)
        end
      end
    end

    context 'when contentful responses with error' do
      it 'shows error' do
        VCR.use_cassette('contentful/recipes_error') do
          get root_path
          expect(response).to render_template('shared/error')
          expect(page.css('.error').count).to eq(1)
        end
      end
    end
  end

  describe 'show' do
    context 'when contentful responses with recipe' do
      it 'shows recipe' do
        VCR.use_cassette('contentful/recipe_success') do
          get recipe_path('4dT8tcb6ukGSIg2YyuGEOm')
          expect(response).to render_template(:show)
          expect(page.css('#card .image').count).to eq(1)
          expect(page.css('#card .data').count).to eq(1)
        end
      end
    end

    context 'when contentful responses with error' do
      it 'shows error' do
        VCR.use_cassette('contentful/recipe_error') do
          get recipe_path('unexisting_id')
          expect(response).to render_template('shared/error')
          expect(page.css('.error').count).to eq(1)
        end
      end
    end
  end
end
