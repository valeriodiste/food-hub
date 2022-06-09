class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
	def change
	  add_column :users, :provider, :string
	  add_column :users, :uid, :string
  
	  # Per effettuare richieste all'API YouTube (aggiunto a mano, non so se è giusto, da vedere se funziona)
	  add_column :users, :token, :string
	  
	end
  end
  