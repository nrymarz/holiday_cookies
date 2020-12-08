class RecipesController < ApplicationController
    get '/recipes' do 
        erb :'recipes/index'
    end

    get '/recipes/new' do 
        erb :'recipes/new'
    end

    get '/recipes/:slug' do
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
