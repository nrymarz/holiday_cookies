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

    post '/recipes' do
    end

    patch '/recipes/:slug' do 
    end

    delete '/recipes/:slug' do 
    end
end
