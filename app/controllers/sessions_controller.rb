class SessionsController < ApplicationController

    def create
        @user = User.find_by(username:login_params[:username])
        # il controllo fallirà sempre, bisogna scrivere authenticate da qualche parte
        if @user && @user.authenticate(login_params[:password])
            session[:user_id] = @user.id
            redirect_to user_path(session[:user_id])
        else
            flash[:login_errors] = ['invalid credentials']
            redirect_to users_path
        end
    end


    private
        def login_params
            params.require(:login).permit(:username, :password)
        end

end