class User < ApplicationRecord

	# Canard roles
	acts_as_user :roles => :admin

	has_many :reviews, dependent: :destroy
	has_many :recipes, dependent: :destroy

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
			# :recoverable, 
			:rememberable, :validatable,
			# :confirmable,	# Aggiungere :confirmable per la conferma via email, forse è questo l'errore che dava
			:omniauthable,	:omniauth_providers => [:google_oauth2]		# Per OAuth (con Google in questo caso)

	def self.from_omniauth(auth)
		
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
			# user.full_name = auth.info.name		# Il model dell'user deve avere un "name"
			# user.avatar_url = auth.info.image		# Il model dell'user deve avere un "image"
			# user.skip_confirmation!	# Serve a skippare l'invio della conferma da parte di Google (utile se stiamo già inviando una mail con :confirmable)

			user.token = auth.credentials.token
			user.save!

			user # Ritona l'utente, forse non serve
		end
	end


end
