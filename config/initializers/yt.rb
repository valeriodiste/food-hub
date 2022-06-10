Yt.configure do |config|
	# Non so se queste 2 linee servono, il client id e client secret sono già stati inseriti...
	# config.client_id = '49781862760-4t610gtk35462g.apps.googleusercontent.com'
	# config.client_secret = 'NtFHjZkJcwYZDfYVz9mp8skz9'
	 
	# API key per accedere a funzionalità dell'API che non richiedono un account google o un accesso
	config.api_key = config.api_key = Rails.application.credentials[:youtube][:api_key]

	# Per messaggi di debug più verbosi
	config.log_level = :debug
  end
  