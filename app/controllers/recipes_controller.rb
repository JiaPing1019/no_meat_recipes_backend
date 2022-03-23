# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    if params[:ingredientQuery].present?
      ingredients_query = params[:ingredientQuery].split(' ').join('&')
      @recipes = Recipe.ingredient_search(ingredients_query).page(recipe_params[:page]).per(12)
    else
      @recipes = Recipe.all.page(recipe_params[:page]).per(12)
    end

    @recipes = @recipes.present? ? @recipes.includes(:category, :ingredients) : []

    render status: :ok, json: {
      recipes: ActiveModelSerializers::SerializableResource.new(@recipes, each_serializer: V1::RecipeSerializer)
    }
  end

  private

  def recipe_params
    params.permit(:page, :ingredientQuery)
  end
end
