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
        if Helpers.logged_in?(session) && Helpers.current_user(session) == @recipe.user
            erb :'recipes/edit'
        else
            @error = "You must be the creator of this recipe to edit it."
            erb :'recipes/edit'
        end
    end

    get '/recipes/:slug/delete' do
        @recipe = Recipe.find_by_slug(params[:slug])
        if Helpers.logged_in?(session) && Helpers.current_user(session) == @recipe.user
            erb :'recipes/delete'
        else
            @error = "You must be the creator of this recipe to delete it."
            erb :'recipes/delete'
        end
    end

    post '/recipes/new' do
        details = Helpers.build_hash_with_directions_and_ingredients(params[:recipe][:plain_directions],params[:recipe][:plain_ingredients])
        params[:recipe][:ingredients] = details[:recipe][:ingredients].collect{|ingredient| Ingredient.new(content: ingredient)}
        params[:recipe][:directions] = details[:recipe][:directions].collect{|direction| Direction.new(content: direction)}
            
        if params[:recipe][:name].size > 0
            recipe = Recipe.create(params[:recipe])
            recipe.chef = Helpers.current_user(session).name
            recipe.user = Helpers.current_user(session)

            details.delete(:recipe)
            details.each do |key,value|
                sub_recipe = SubRecipe.new(name: key.to_s)
                sub_recipe.directions = value[:directions].collect{|direction| Direction.new(content: direction)} if value[:directions]
                sub_recipe.ingredients = value[:ingredients].collect{|ingredient| Ingredient.new(content: ingredient)} if value[:ingredients]
                recipe.sub_recipes << sub_recipe
            end
            recipe.save
            redirect "/recipes/#{recipe.slug}"

        else
            @error = "Please Provide Recipe with Title"
            erb :'recipes/new'
        end
    end

    patch '/recipes/:slug' do 
        details = Helpers.build_hash_with_directions_and_ingredients(params[:recipe][:plain_directions],params[:recipe][:plain_ingredients])
        params[:recipe][:ingredients] = details[:recipe][:ingredients].collect{|ingredient| Ingredient.new(content: ingredient)}
        params[:recipe][:directions] = details[:recipe][:directions].collect{|direction| Direction.new(content: direction)}
            
        if params[:recipe][:name].size > 0
            recipe = Recipe.find_by_slug(params[:slug])
            recipe.update(params[:recipe])

            details.delete(:recipe)
            recipe.sub_recipes.clear
            details.each do |key,value|
                sub_recipe = SubRecipe.new(name: key.to_s)
                sub_recipe.directions = value[:directions].collect{|direction| Direction.new(content: direction)} if value[:directions]
                sub_recipe.ingredients = value[:ingredients].collect{|ingredient| Ingredient.new(content: ingredient)} if value[:ingredients]
                recipe.sub_recipes << sub_recipe
            end
            recipe.save
            redirect "/recipes/#{recipe.slug}"
        else
            @error = "Please Provide Recipe with Title"
            @recipe = Recipe.find_by_slug(params[:slug])
            erb :"/recipes/edit"
        end
    end

    delete '/recipes/:slug' do 
        recipe = Recipe.find_by_slug(params[:slug])
        recipe.destroy
        redirect "/users/#{Helpers.current_user(session).slug}"
    end
end
