# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the login page/
      '/users/sign_in'

    when /^the sign up page/
      '/users/sign_up'

    when /^the profile page/
      '/profiles'

    when /^the new recipe page/
      '/users/1/recipes/new'
     
    when /^the recipe list page/
      '/recipes'

    when /^the recipe info page/
      '/recipes/1'

    when /^the video uploads page/
      '/video_uploads'
     


    # spoonocular paths
    when /^the spoonocular recipe list page/
      '/search'
      
    when /^the spoonocular recipe info page/
      '/search_recipe_info/654959'

    when /^the spoonocular ingredient info page/
      '/search_ingredient_info/20081'

      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
