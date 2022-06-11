class ReviewsController < ApplicationController

	#skip_before_action :authenticate_user!, only: [:index, :show]
	before_action :authenticate_user!


	before_action :set_review, only: %i[ show edit update destroy ]

	# GET /reviews or /reviews.json
	def index
		#non viene mai utilizzata
		@reviews = Review.all
	end

	# GET /reviews/1 or /reviews/1.json
	def show
		#non viene mai utilizzata
		
		# Autorizzazioni (Canard + CanCan)
		# authorize! :read, @review, :message => "BEWARE: you are not authorized to see reviews."
	end

	# GET /reviews/new
	def new
		# if (!session[:user_id]||session[:user_id]=="")
		#   redirect_to users_path(session[:user_id])
		# else

		
		#id_user = session[:user_id]
		#@user = User.find(id_user)
		id_recipe = params[:recipe_id]
		@recipe = Recipe.find(id_recipe) 
		@review = Review.new
		
		# Autorizzazioni (Canard + CanCan)
		authorize! :create, @review, :message => "BEWARE: you are not authorized to create new review."
		
		#end
	end

	# GET /reviews/1/edit
	def edit
		# Autorizzazioni (Canard + CanCan)
		authorize! :update, @review, :message => "BEWARE: you are not authorized to update reviews."
	end

	# POST /reviews or /reviews.json
	def create

		@user = current_user

		# id_user = session[:user_id]
			# @user = User.find(id_user)

		id_recipe = params[:recipe_id]
		@recipe = Recipe.find(id_recipe) 
		@review = Review.new(review_params)
		@review.recipe = @recipe
		@review.user = @user

		# Autorizzazioni (Canard + CanCan)
		authorize! :create, @review, :message => "BEWARE: you are not authorized to create new review."

		respond_to do |format|
			if @review.save
				format.html { redirect_to recipe_path(@recipe.id), notice: "Review was successfully created." }
				# format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
				format.json { render :show, status: :created, location: @review }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @review.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /reviews/1 or /reviews/1.json
	def update
		# Autorizzazioni (Canard + CanCan)
		authorize! :update, @review, :message => "BEWARE: you are not authorized to update reviews."

		respond_to do |format|
			if @review.update(review_params)
				format.html { redirect_to profiles_path, notice: "Review was successfully updated." }
				# format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
				format.json { render :show, status: :ok, location: @review }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @review.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /reviews/1 or /reviews/1.json
	def destroy

		# Autorizzazioni (Canard + CanCan)
		if (current_user != @review.user)
			authorize! :destroy, @review, :message => "BEWARE: you are not authorized to delete reviews."
		end

		@review.destroy

		respond_to do |format|
			format.html { redirect_back_or_to root_path, notice: "Review was successfully destroyed." }
			# format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_review
			@review = Review.find(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def review_params
			params.require(:review).permit(:rating, :description)
		end
end
