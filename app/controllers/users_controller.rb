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

    post '/signup' do 
        user = User.new(name: params[:name], password: params[:password])
        if user.save
            session[:user_id] = user.id 
            redirect "/users/#{user.slug}"
        else
            @error = user.errors.full_messages.join(' - ')
            erb :'users/signup'
        end
    end
end