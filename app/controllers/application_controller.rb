class ApplicationController < ActionController::Base

	# Gestione dell'eccezione per operazione con mancato permesso/autorizzazione (Canard + CanCan)
	rescue_from CanCan::AccessDenied do |exception|
		redirect_back_or_to root_path, :alert => exception.message	# Genera un alert (nella pagina corrente o reindirizza alla root se la pagina corrente non è accessibile)
	end

end
