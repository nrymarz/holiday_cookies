class Helpers
    def self.logged_in?(session)
        !!session[:user_id]
    end

    def self.current_user(session)
        User.find(session[:user_id])
    end

    def self.seperate_recipe_details(string)
        details = {}
        sub_recipes = string.scan(/\*\w+\*/)
        sub_recipes.each do |sub_recipe|
            sub_recipe_details = string.split(sub_recipe).last
            next_sub_recipe = sub_recipe_details.match(/\*\w+\*/)
            if next_sub_recipe
                sub_recipe_details = sub_recipe_details.match(/.+\*\w+\*/).to_s
                sub_recipe_details.delete(next_sub_recipe.to_s)
            end
            sub_recipe.delete!('*')
            details[sub_recipe.to_sym] = split_by_numbers(sub_recipe_details).join('---')
        end
        recipe_details = string.split(/\*\w+\*/).first
        if recipe_details.size > 0 
            details[:recipe] = split_by_numbers(recipe_details).join('---')
        else
            details[:recipe] = ''
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
      
    