class SessionController < ApplicationController
    get '/login' do 
        if !Helpers.logged_in?(session)
            erb :'users/login'
        else
            @error = "You are Already Logged In. 
            Heres Your <a href='/users/#{Helpers.current_user(session).slug}'>Profile Page</a>"
            erb :'users/login'
        end
    end

    get '/logout' do
        if Helpers.logged_in?(session)
            erb :'users/logout'
        else
            @error = "You are not logged In. <a href='/login'>Log In</a>"
            erb :'users/logout'
        end
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

    