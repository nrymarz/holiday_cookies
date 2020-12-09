class SessionController < ApplicationController
    get '/login' do 
        erb :'users/login'
    end
    
    get '/logout' do 
    end

    post '/login' do 
        user = User.find_by_name(params[:name])
        if user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.slug}"
        end
    end

end

    