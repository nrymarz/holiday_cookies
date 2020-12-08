class SessionController < ApplicationController
    get '/login' do 
        erb :'users/login'
    end
    
    get '/logout' do 
    end
    
end

    