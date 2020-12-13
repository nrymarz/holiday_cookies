class Helpers
    def self.logged_in?(session)
        !!session[:user_id]
    end

    def self.current_user(session)
        User.find(session[:user_id])
    end

    def self.build_hash_with_directions_and_ingredients(directions_string,ingredients_string)
        directions = seperate_recipe_details(directions_string)
        ingredients = seperate_recipe_details(ingredients_string)
        hash = {}
        directions.each do |key,value|
            if hash[key]
                hash[key][:directions] = value
            else
                hash[key] = {}
                hash[key][:directions] = value
            end
            if ingredients.include?(key)
                hash[key][:ingredients] = ingredients[key]
                ingredients.delete(key)
            end
        end
        ingredients.each do |key,value|
            if hash[key]
                hash[key][:ingredients] = value
            else
                hash[key] = {}
                hash[key][:ingredients] = value
            end
        end
        hash
    end

    def self.seperate_recipe_details(string)
        details = {}
        sub_recipes = string.scan(/\*\w+\*/)
        sub_recipes.each do |sub_recipe|
            sub_recipe_details = string.split(sub_recipe).last
            if sub_recipe_details.match(/\*\w+\*/)
                sub_recipe_details = sub_recipe_details.split(/\*\w+\*/).first
            end
            sub_recipe.delete!('*')
            details[sub_recipe.to_sym] = split_by_numbers(sub_recipe_details)
        end
        recipe_details = string.split(/\*\w+\*/).first
        if recipe_details.size > 0 
            details[:recipe] = split_by_numbers(recipe_details)
        else
            details[:recipe] = []
        end
        details
    end

    def self.split_by_numbers(string)
        arr = string.split('1.')
        num = 2
        while(arr.last && arr.last.include?("#{num}."))
            substring = arr.last.split("#{num}.")
            arr.pop
            arr.push(substring)
            num += 1
            arr.flatten!
        end
        if arr.last
            arr[1..].collect{|s|s.strip}
        else
            []
        end
    end
end
      
    