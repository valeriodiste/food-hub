
require 'rails_helper'


RSpec.describe OperationsController, :type => :controller do

    describe "GET index" do
      it "assigns @random_recipe to correct value" do
        recipe = controller.find_random_recipe()
        get :index
        expect(assigns(:random_recipe).length).to eq(recipe.length)
      end
  
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end

      it "returns a correct status code" do
        get :index
        expect(expect(response.status).to eq(200))
      end

    end


    describe "find recipe name" do
      it "assigns @recipes to correct value" do
        recipe = controller.find_recipe("pasta")
        get :search, params: {:recipe => 'pasta'}
        expect(assigns(:recipe)).to eq(recipe)
      end
  
    end


    describe "GET search_recipe_info" do
      it "assigns @recipe_info to correct value" do
        recipe_info = controller.find_recipe_info('654959')
        similar = controller.find_similar_recipe('654959')
        recipe = Array.new
        recipe << recipe_info
        recipe << similar
        get :search_recipe_info, params: {id: '654959'}
        expect(assigns(:recipe_info)).to eq(recipe)
      end
  
      it "renders the search_recipe_info template" do
        get :search_recipe_info, params: {id: '654959'}
        expect(response).to render_template("search_recipe_info")
      end

      it "returns a correct status code" do
        get :search_recipe_info, params: {id: '654959'}
        expect(expect(response.status).to eq(200))
      end

    end


    describe "GET search_ingredient_info" do
      it "assigns @ingredient_info to correct value" do
        ingredient_info = controller.find_ingredient_info('20081')
        get :search_ingredient_info, params: {id: '20081'}
        expect(assigns(:ingredient_info)).to eq(ingredient_info)
      end
  
      it "renders the search_ingredient_info template" do
        get :search_ingredient_info, params: {id: '20081'}
        expect(response).to render_template("search_ingredient_info")
      end

      it "returns a correct status code" do
        get :search_ingredient_info, params: {id: '20081'}
        expect(expect(response.status).to eq(200))
      end

    end


  end