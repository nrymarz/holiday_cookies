class Helpers
    def self.logged_in?(session)
        !!session[:user_id]
    end

    def self.current_user(session)
        User.find(session[:user_id])
    end

    def self.seperate_recipe_details(string)
        arr = string.split("1.")
        n = 2
        if arr.last 
            while(arr.last.include?("#{n}."))
                substring = arr.last.split("#{n}.")
                arr.pop
                arr.push(substring)
                n += 1
                arr.flatten!
            end
            arr = arr[1..].collect{|s|s.strip}
            arr.join('---')
        else
            ''
        end
    end
end
      
    