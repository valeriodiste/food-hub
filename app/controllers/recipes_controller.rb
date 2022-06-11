class RecipesController < ApplicationController


	# da modificare per quando l'utente si logga
	# skip_before_action :require_login, only: [:index, :show]
	# before_action :require_login

	# private
	# def require_login
	#   unless logged_in?
	#     flash[:error] = "You must be logged in to access this section"
	#     redirect_to new_login_url # halts request cycle
	#   end
	# end


	# bisogna inserirlo in tutte le pagine che richiedono il login

	before_action :authenticate_user!, only: %i[:index, :show]
	# skip_before_action :authenticate_user, only: [:index, :show]

	# private
	# def require_login
	#   unless logged_in?
	#     flash[:error] = "You must be logged in to access this section"
	#     redirect_to new_login_url # halts request cycle
	#   end
	# end


	before_action :set_recipe, only: %i[ show edit update destroy ]

	# GET /recipes or /recipes.json
	def index
		@recipes = Recipe.all
	end

	# GET /recipes/1 or /recipes/1.json
	def show
		# authorize! :read, @recipe, :message => "BEWARE: you are not authorized to see recipes."
	end

	# GET /recipes/new
	def new
		#può essere che id user e @user non servano
		# id_user = session[:user_id]
		# @user = User.find(id_user)

		@user = current_user
		@recipe = Recipe.new

		# Autorizzazioni (Canard + CanCan)
		authorize! :create, @recipe, :message => "BEWARE: you are not authorized to create new recipe."
	end

	# GET /recipes/1/edit
	def edit
		# Autorizzazioni (Canard + CanCan)
		authorize! :update, @recipe, :message => "BEWARE: you are not authorized to update recipes."
	end

	# POST /recipes or /recipes.json
	def create
		# id_user = session[:user_id]
		# @user = User.find(id_user)

		@user = current_user
		@recipe = Recipe.new(recipe_params)
		@recipe.user = @user

		# Autorizzazioni (Canard + CanCan)
		authorize! :create, @recipe, :message => "BEWARE: you are not authorized to create new recipe."

		respond_to do |format|
		if @recipe.save
			# redirect_to user_path(session[:user_id])
			# format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
			format.html { redirect_to video_uploads_path(params: { recipetitle: recipe_params['title'] }), notice: "Recipe was successfully created." }
			format.json { render :show, status: :created, location: @recipe }
		else
			format.html { render :new, status: :unprocessable_entity }
			format.json { render json: @recipe.errors, status: :unprocessable_entity }
		end
		end
	end

	# PATCH/PUT /recipes/1 or /recipes/1.json
	def update

		# Autorizzazioni (Canard + CanCan)
		authorize! :update, @recipe, :message => "BEWARE: you are not authorized to update recipes."

		respond_to do |format|
			if @recipe.update(recipe_params)
				format.html { redirect_to profiles_path, notice: "Recipe was successfully updated." }
				# format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully updated." }
				format.json { render :show, status: :ok, location: @recipe }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @recipe.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /recipes/1 or /recipes/1.json
	def destroy

		# Autorizzazioni (Canard + CanCan)
		if (current_user != @recipe.user)
			authorize! :destroy, @recipe, :message => "BEWARE: you are not authorized to delete recipes."
		end

		@recipe.destroy

		# puts "RECIPE: " + request.base_url + recipe_path
		# puts request.referer.to_s

		respond_to do |format|
			if (request.base_url + recipe_path == request.referer.to_s)
				format.html { redirect_to recipes_path, notice: "Recipe was successfully destroyed." }
			else
				format.html { redirect_back_or_to root_path, notice: "Recipe was successfully destroyed." }
			end
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_recipe
		@recipe = Recipe.find(params[:id])
	end
	# Only allow a list of trusted parameters through.
	def recipe_params
		params.require(:recipe).permit(:title, :typology, :description)
	end
end
