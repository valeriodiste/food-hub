class OperationsController < ApplicationController

    require "http"

# bisogna modificare i numeri di risultati che appaiono
    def find_random_recipe()
        response = HTTP.timeout(10).get("https://api.spoonacular.com/recipes/random", :params => {:apiKey => Rails.application.credentials[:spoonocular][:api_key], :number => '0'})
        return nil if response.status != 200
        response.parse['recipes']
    end

    def index
        random_recipe = find_random_recipe()
        @random_recipe = random_recipe
    end




    
    def request_api(url)
        response = HTTP.timeout(10).get(url, :params => {:apiKey => Rails.application.credentials[:spoonocular][:api_key], :addRecipeInformation => 'true', :number => '3'})
        return nil if response.status != 200
        response.parse['results']
        #JSON.parse(response.results)
    end

    def find_recipe(name)
      request_api(
        "https://api.spoonacular.com/recipes/complexSearch?query=#{URI.encode_www_form_component(name)}"
      )
    end

    def search
        recipes = find_recipe(params[:recipe])
        if recipes.length<1
          flash[:alert] = 'Recipe not found'
          return render action: :index
        end
        @recipe = recipes.first(20)
    end





    def find_recipe_info(id)
        response = HTTP.timeout(10).get("https://api.spoonacular.com/recipes/#{id}/information", :params => {:apiKey => Rails.application.credentials[:spoonocular][:api_key]})
        return nil if response.status != 200
        response.parse()
    end

    def find_similar_recipe(id)
        response = HTTP.timeout(10).get("https://api.spoonacular.com/recipes/#{id}/similar", :params => {:apiKey => Rails.application.credentials[:spoonocular][:api_key], :number => '3'})
        return nil if response.status != 200
        response.parse()
    end

    def search_recipe_info
        recipe_info = find_recipe_info(params[:id])
        similar = find_similar_recipe(params[:id])
        @recipe_info = Array.new
        @recipe_info << recipe_info
        @recipe_info << similar
    end





    def find_ingredient_info(id)
        response = HTTP.timeout(10).get("https://api.spoonacular.com/food/ingredients/#{id}/information", :params => {:apiKey => Rails.application.credentials[:spoonocular][:api_key], :amount => '100', :unit => 'grams'})
        return nil if response.status != 200
        response.parse()
    end

    def search_ingredient_info
        ingredient_info = find_ingredient_info(params[:id])
        @ingredient_info = ingredient_info
    end




    def search_diet_type(diet_type)
        response = HTTP.timeout(10).get("https://api.spoonacular.com/recipes/complexSearch?diet=#{diet_type}", :params => {:apiKey => Rails.application.credentials[:spoonocular][:api_key], :addRecipeInformation => 'true', :number => '3'})
        return nil if response.status != 200
        response.parse['results']
    end

    def search_diet
        recipes = search_diet_type(params[:type])
        flash[:alert] = params[:type]
        @recipe = recipes.first(20)
    end




    # def search_diet(diet_type)
    #     response = HTTP.timeout(10).get("https://api.spoonacular.com/recipes/complexSearch?diet=#{diet_type}", :params => {:apiKey => Rails.application.credentials[:spoonocular][:api_key], :addRecipeInformation => 'true', :number => '3'})
    #     return nil if response.status != 200
    #     response.parse['results']
    # end

    # def search_glutenfree
    #     recipes = search_diet(params[:type])
    #     @recipe = recipes.first(20)
    # end

    # def search_vegetarian
    #     recipes = search_diet(params[:type])
    #     @recipe = recipes.first(20)
    # end

    # def search_vegan
    #     recipes = search_diet(params[:type])
    #     @recipe = recipes.first(20)
    # end





    # def trigger
    #     op_id = params[:id]
    #     if op_id == '1'
    #         if Spoonocular.get_random_recipes
    #             @message.add_value
    #         else
    #             @message = 'Failed'
    #         end
    #     else
    #         @message = 'Not valid operation'
    #     end
    # end

end