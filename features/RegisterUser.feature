Feature: User can register to the site
  come visitatore
  in modo che il sistema si ricordi di me
  voglio registrarmi con un account

Scenario: Registration
  Given I am on the home page
  When I follow "Login"
  Then I should be on the login page
  When I follow "Sign up"
  Then I should be on the sign up page
  When I fill in "Email" with "test@gmail.com"
  And I fill in "Password" with "password"
  And I fill in "Password confirmation" with "password"
  And I press "Sign up"
  Then I should be on the home page