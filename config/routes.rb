Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "operations#index"

  get "/search" => "operations#search"

  get "/search_recipe_info/:id" => "operations#search_recipe_info"

  get "/search_ingredient_info/:id" => "operations#search_ingredient_info"

  get "/search_diet/:type" => "operations#search_diet"

  resources :recipes do
    resources :reviews
  end

  # non so se è corretto, ma al momento funziona
  resources :users do
    resources :reviews
    resources :recipes
  end

  resources :reviews

  # da eliminare
  post "/sessions" => "sessions#create"



  # non so se sono definitivi, però al momento funzionano
  get "/recipes_destroy/:id" => "recipes#destroy"
  get "/reviews_destroy/:id" => "reviews#destroy"

  get "/profiles" => "profiles#index"
  # post "/profiles" => "users#create"

  #post "/users" => "users#create"

  # resources :users

  #resources :recipes
  # get "/recipes#index" => "recipes#index"
  # get "/recipes/:id" => "recipes#show"


  # get "/search_glutenfree/:type" => "operations#search_glutenfree"

  # get "/search_vegetarian/:type" => "operations#search_vegetarian"

  # get "/search_vegan/:type" => "operations#search_vegan"

  

  #get "/operations/:id", to: "operations#trigger"


end
