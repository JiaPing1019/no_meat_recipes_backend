# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = Recipe.page(recipe_params[:page]).includes(:category, :ingredients)

    render status: :ok, json: {
      recipes: ActiveModelSerializers::SerializableResource.new(@recipes, each_serializer: V1::RecipeSerializer)
    }
  end

  private

  def recipe_params
    params.permit(:page, :query)
  end
end
