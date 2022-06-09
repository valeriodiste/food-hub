class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def google_oauth2
		# You need to implement the method below in your model (e.g. app/models/user.rb)

		@user = User.from_omniauth(request.env["omniauth.auth"])
		# Serve per il token per effettuare richieste all'API, non so se è giusto e se funziona...
		if @user.persisted?		# Se l'utente esiste già nel database locale
			sign_in_and_redirect @user, :event => :authentication	# This will throw if @user is not activated
			set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
			
		else					# Se l'utente non esiste nel database locale (viene registrato con Google)
			session["devise.google_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end

		@user.token = request.env["omniauth.auth"].credentials.token
		@user.save!
		
	end

	# def google_oauth2
	# 	@user = User.from_omniauth(request.env['omniauth.auth'])
	
	# 	 flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
	# 	 sign_in_and_redirect @user, event: :authentication
	# end

	def failure
		redirect_to root_path
	end

end