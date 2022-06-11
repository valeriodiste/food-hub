# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Elimina tutti i record nelle tabelle prima di applicare il seed
User.destroy_all
Recipe.destroy_all
Review.destroy_all


# Adding users
# =begin
more_user = [
	{:email => 'mario@gmail.com', :password => 'password'},
	{:email => 'anna@gmail.com', :password => 'password'},
	{:email => 'gianni@gmail.com', :password => 'password'}
]
more_user.each do |user|
  	u = User.create!(user)
	u.roles << :user
	u.save!
end

# Crea utente amministratore
admin_user = User.create!({:email => 'valerio@gmail.com', :password => 'password'})
admin_user.roles << :admin
admin_user.save!

admin_user = User.create!({:email => 'giuseppe@gmail.com', :password => 'password'})
admin_user.roles << :admin
admin_user.save!
# =end


# adding some recipes
# =begin
n_of_users = User.all.size - 1
first_id_of_user = User.first.id
user_id_to_assing_1 = rand(first_id_of_user..(first_id_of_user + n_of_users - 1))
user_id_to_assing_2 = user_id_to_assing_1 + 1

more_recipes = [
    {:title => 'Pasta e Vongole', :user_id => user_id_to_assing_1,
      :typology => 'Main Course', :description => 'Primo piatto di pasta e vongole'},
    {:title => 'Pasta e Patate', :user_id => user_id_to_assing_1,
      :typology => 'Main Course', :description => 'Primo piatto di pasta e patate'},
    {:title => 'Carbonara', :user_id => user_id_to_assing_2,
      :typology => 'Main Course', :description => 'Primo piatto di carbonara'},
    {:title => 'Cotoletta', :user_id => user_id_to_assing_2,
      :typology => 'Side', :description => 'Secondo piatto di cotolette'}
]
  
more_recipes.each do |recipe|
  Recipe.create!(recipe)
end
# =end


# settarle manualmente per ogni utente perché assegnandole randomicamente può accadere 
# che venga assegnata una recensione per una stessa coppia ricetta utente
# e quindi non viene aggiunta al database

# adding some reviews
# =begin
more_reviews = [
	{:rating => 2, :description => 'Potrebbe essere migliorata'},
	{:rating => 5, :description => 'Molto buona!'},
	{:rating => 3, :description => 'Decente'},
	{:rating => 1, :description => 'Non mi è piaciuta'},
	{:rating => 1, :description => 'Disgustosa'},
	{:rating => 4, :description => 'Sembra interessante!'},
]

# random assignment

n_of_users = User.all.size - 1
first_id_of_user = User.first.id
# rand(first_id_of_user..(first_id_of_user + n_of_users))

n_of_recipes = Recipe.all.size - 1
first_id_of_recipe = Recipe.first.id
# rand(first_id_of_recipe..(first_id_of_recipe + n_of_recipes))

more_reviews.each do |review|
  r = Review.new(review)
  r.recipe = Recipe.find(rand(first_id_of_recipe..(first_id_of_recipe + n_of_recipes)))
  r.user = User.find(rand(first_id_of_user..(first_id_of_user + n_of_users)))
  r.save
end
# =end