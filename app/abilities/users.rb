Canard::Abilities.for(:user) do
  can [:read, :create, :update], Recipe
  cannot [:destroy], Recipe
  can [:read, :create, :update], Review
  cannot [:destroy], Review
end
