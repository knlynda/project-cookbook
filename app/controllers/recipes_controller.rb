# frozen_string_literal: true

class RecipesController < ApplicationController
  include ::ProjectCookbook::Import['contentful_repository']

  def index
    result = contentful_repository.fetch_recipes(
      limit: ITEMS_PER_PAGE,
      skip:  page_param.pred * ITEMS_PER_PAGE
    )

    if result.success?
      render(locals: { recipes: result.success })
    else
      render('shared/error', locals: { error: result.failure })
    end
  end

  def show
    result = contentful_repository.fetch_recipe(id: params[:id])

    if result.success?
      render(locals: { recipe: result.success })
    else
      render('shared/error', locals: { error: result.failure })
    end
  end

  private

  ITEMS_PER_PAGE = 10
  private_constant :ITEMS_PER_PAGE

  DEFAULT_PAGE = 1
  private_constant :DEFAULT_PAGE

  def page_param
    params.fetch(:page, DEFAULT_PAGE).to_i
  end
end
