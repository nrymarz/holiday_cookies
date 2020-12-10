class RecipesController < ApplicationController

    get '/recipes' do
        @recipes = Recipe.all
        erb :index
    end

    get '/recipes/new' do 
        if Helpers.logged_in?(session)
            erb :'recipes/new'
        else
            @error = "Please <a href='/login'>Log In</a> to create recipes."
            erb :'recipes/new'
        end
    end

    get '/recipes/:slug' do
        @recipe = Recipe.find_by_slug(params[:slug])
        erb :'recipes/show'
    end

    get '/recipes/:slug/edit' do 
        @recipe = Recipe.find_by_slug(params[:slug])
        erb :'recipes/edit'
    end

    post '/recipes/new' do
        ingredients_details = Helpers.seperate_recipe_details(params[:recipe][:ingredients])
        directions_details = Helpers.seperate_recipe_details(params[:recipe][:directions])
        params[:recipe][:ingredients] = ingredients_details[:recipe]
        params[:recipe][:directions] = directions_details[:recipe]
            
        if params[:recipe][:name].size > 0
            recipe = Recipe.create(params[:recipe])
            recipe.chef = Helpers.current_user(session).name
            recipe.user = Helpers.current_user(session)

            ingredients_details.delete(:recipe)
            directions_details.delete(:recipe)
            ingredients_details.each do |key,value|
                if directions_details.include?(key)
                    subrecipe = SubRecipe.new(name: key.to_s, ingredients: value, directions:directions_details[key])
                    directions_details.delete(key)
                else
                    subrecipe = SubRecipe.new(name: key.to_s, ingredients: value, directions: '')
                end
                recipe.sub_recipes << subrecipe
            end
            directions_details.each do |key,value|
                subrecipe = SubRecipe.new(name: key.to_s, directions:value, ingredients: '')
                recipe.sub_recipes << subrecipe
            end

            recipe.save
            binding.pry
            redirect "/recipes/#{recipe.slug}"
        else
            @error = "Please Provide Recipe with Title"
            erb :'recipes/new'
        end
    end

    patch '/recipes/:slug' do 
    end

    delete '/recipes/:slug' do 
    end
end
