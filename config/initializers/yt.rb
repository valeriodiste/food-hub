Yt.configure do |config|
	
	# API key per accedere a funzionalità dell'API che non richiedono un account google o un accesso
	config.api_key = Rails.application.credentials[:youtube][:api_key]

	# Per messaggi di debug più verbosi
	config.log_level = :debug
  end
  