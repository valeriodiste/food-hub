Feature: Find Ingredient from recipe

Scenario: Find Ingredient from a recipe
  Given I am on the home page
  When I fill in "recipe" with "pasta"
  And I press "Search"
  Then I should be on the spoonocular recipe list page
  When I follow "Pasta With Tuna"
  Then I should be on the spoonocular recipe info page
  When I follow "flour"
  Then I should be on the spoonocular ingredient info page
  When I follow "Home Page"
  Then I should be on the home page
