class UsersController < ApplicationController
    get '/users/:slug' do 
        erb :'users/show'
    end

    get '/users' do 
        erb :'users/index'
    end

    get '/signup' do
        erb :'users/signup'
    end

    post '/users' do 
    end
    
    patch '/users/:slug' do
    end

    get '/users/:slug/edit' do 
        erb :'users/edit'
    end
end