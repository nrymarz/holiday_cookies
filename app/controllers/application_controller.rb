class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "notasecret"
    end

    get '/' do 
        @recipes = Recipe.all
        erb :index
    end
end