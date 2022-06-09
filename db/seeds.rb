# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)




more_user = [
	{:email => 'mario@gmail.com', :password => 'aaaaaaaa'},
	{:email => 'anna@gmail.com', :password => 'aaaaaaaa'},
	{:email => 'gianni@gmail.com', :password => 'aaaaaaaa'}
]

more_user.each do |user|
  User.create!(user)
end


# adding some recipes
more_recipes = [
    {:title => 'Pasta e Vongole', :user_id => '1',
      :typology => 'Main Course', :description => 'Primo piatto di pasta e vongole'},
    {:title => 'Pasta e Patate', :user_id => '1',
      :typology => 'Main Course', :description => 'Primo piatto di pasta e patate'},
    {:title => 'Carbonara', :user_id => '2',
      :typology => 'Main Course', :description => 'Primo piatto di carbonara'},
    {:title => 'Cotoletta', :user_id => '2',
      :typology => 'Side', :description => 'Secondo piatto di cotolette'}
]
  
more_recipes.each do |recipe|
  Recipe.create!(recipe)
end


# settarle manualmente per ogni utente perché assegnandole randomicamente può accadere 
# che venga assegnata una recensione per una stessa coppia ricetta utente
# e quindi non viene aggiunta al database

# adding some reviews
more_reviews = [
	{:rating => 2, :description => 'Potrebbe essere migliorata'},
	{:rating => 5, :description => 'Molto buona!'},
	{:rating => 3, :description => 'Decente'},
  {:rating => 1, :description => 'Non mi è piaciuta'},
  {:rating => 1, :description => 'Disgustosa'},
  {:rating => 4, :description => 'Sembra interessante!'},
]


# random assignment
recipe_counter = Recipe.all.size
user_counter = User.all.size
more_reviews.each do |review|
  r = Review.new(review)
  r.recipe = Recipe.find(rand(1..recipe_counter))
  r.user = User.find(rand(1..user_counter))
  r.save
end