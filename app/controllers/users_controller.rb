class UsersController < ApplicationController
    get '/users/:slug' do 
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

    get '/users' do 
        @users = User.all
        erb :'users/index'
    end

    get '/signup' do
        if !Helpers.logged_in?(session)
            erb :'users/signup'
        else
            @error = "You are Already Logged In. 
            Heres Your <a href='/users/#{Helpers.current_user(session).slug}'>Profile Page</a>"
            erb :'users/signup'
        end
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