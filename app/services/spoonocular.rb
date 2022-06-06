require "http"
# da eliminare perché le funzionalità sono state implementate in operations_controller
class Spoonocular

    def self.get_random_recipes
        attempts = 0
        begin
            attempts += 1
            response = HTTP.timeout(10).get("https://api.spoonacular.com/recipes/random", :params => {:apiKey => Rails.application.credentials[:spoonocular][:api_key], :number => '1'})
        rescue => e
            if attempts < 10
                #sleep(1)
                retry
            else
                return false
            end
        end
        
        results = response.parse['recipes']
        results.each do |r|
            attempts = 0
            p r["title"]
            @@prova = r["title"]
            begin
                attempts += 1
                recipe_id = r['id']
                response = HTTP.timeout(10).get("https://api.spoonacular.com/recipes/#{recipe_id}/similar", :params => {:apiKey => Rails.application.credentials[:spoonocular][:api_key], :number => '2'})
            rescue => e
                if attempts < 10
                    #sleep(1)
                    retry
                else
                    return false
                end
            end
            results = response.parse
#            p results
            results.each do |r|
                p r["title"]
            end
        end
        return true
    end
end