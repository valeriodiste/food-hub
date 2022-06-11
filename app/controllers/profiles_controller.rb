class ProfilesController < ApplicationController
    
    # before_action :set_user, only: %i[ show edit update destroy ]
  
    before_action :authenticate_user!

    def index
        @user = current_user
    end
  
    # GET /users/1 or /users/1.json
    def show
        # non è ancora usata
        
        # inserire il controllo per vedere se si è amministratori e poi aggiungere anche il controllo
        #  nella index di profiles per far apparire il bottone "vedi tutti gli utenti"

		@users = User.all
    end
  
    # # GET /users/new
    # def new
    #   @user = User.new
    # end
  
    # # GET /users/1/edit
    # def edit
    # end
  
    # # POST /users or /users.json
    # def create
    #   @user = User.new(user_params)
  
    #   respond_to do |format|
    #     if @user.save
    #       session[:user_id] = @user.id
    #       # redirect_to "/users/show"
  
    #       format.html { redirect_to user_url(@user), notice: "User was successfully created." }
    #       format.json { render :show, status: :created, location: @user }
    #     else
    #       flash[:registration_errors] = ['could not create user']
    #       format.html { render :new, status: :unprocessable_entity }
    #       format.json { render json: @user.errors, status: :unprocessable_entity }
    #     end
    #   end
    # end
  
    # # PATCH/PUT /users/1 or /users/1.json
    # def update
    #   respond_to do |format|
    #     if @user.update(user_params)
    #       format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
    #       format.json { render :show, status: :ok, location: @user }
    #     else
    #       format.html { render :edit, status: :unprocessable_entity }
    #       format.json { render json: @user.errors, status: :unprocessable_entity }
    #     end
    #   end
    # end
  
    # DELETE /users/1 or /users/1.json
    def destroy

		set_user()

		# Autorizzazioni (Canard + CanCan)
		authorize! :destroy, @user, :message => "BEWARE: you are not authorized to delete users."

		if @user.admin?
			redirect_back_or_to root_path, notice: "You cannot delete an admin." 
		else
			@user.destroy
			# session.clear
			# session[:user_id] = ""
			respond_to do |format|
				format.html { redirect_back_or_to root_path, notice: "User was successfully destroyed." }
				format.json { head :no_content }
			end
		end

    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:username, :password)
      end
	
  end
  