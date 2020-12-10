class RecipesController < ApplicationController

    get '/recipes/new' do 
        erb :'recipes/new'
    end

    get '/recipes/:slug' do
        @recipe = Recipe.find_by_slug(params[:slug])
        erb :'recipes/show'
    end

    get '/recipes/:slug/edit' do 
        erb :'recipes/edit'
    end

    post '/recipes/new' do
        if Helpers.logged_in?(session)
            params[:recipe][:ingredients] = Helpers.seperate_recipe_details(params[:recipe][:ingredients])
            params[:recipe][:directions] = Helpers.seperate_recipe_details(params[:recipe][:directions])
            if params[:recipe][:name].size > 0 && params[:recipe][:directions].size > 0
                recipe = Recipe.create(params[:recipe])
                recipe.chef = Helpers.current_user(session).name
                recipe.user = Helpers.current_user(session)
                recipe.save
                redirect "/recipes/#{recipe.slug}"
            else
                @error = "Please Provide Recipe with Title and Directions"
                erb :'/recipes/new'
            end
        else
            @error = "You must be logged in to create recipes"
            erb :'/recipes/new'
        end
    end

    patch '/recipes/:slug' do 
    end

    delete '/recipes/:slug' do 
    end
end
