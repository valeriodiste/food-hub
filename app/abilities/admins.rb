Canard::Abilities.for(:admin) do

	includes_abilities_of :user
	
	can [:destroy], Recipe

	can [:destroy], Review

	can [:destroy], User
	
end
