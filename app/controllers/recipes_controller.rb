# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    if params[:ingredientQuery].present?
      @recipes = Recipe.ingredient_search(params[:ingredientQuery]).page(recipe_params[:page]).per(12)
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
