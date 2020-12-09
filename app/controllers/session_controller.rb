class SessionController < ApplicationController
    get '/login' do 
        erb :'users/login'
    end

    get '/logout' do
        erb :'users/logout'
    end
    
    post '/logout' do
        session.clear
        redirect '/' 
    end

    post '/login' do 
        user = User.find_by_name(params[:name])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.slug}"
        else
            @error = "No match found for that User Name and Password"
            erb :'users/login'
        end
    end

end

    