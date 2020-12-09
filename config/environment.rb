require 'sinatra'
require 'require_all'
require 'sqlite3'
require 'thin'
require 'active_record'
require 'sinatra/activerecord'
require 'bcrypt'
ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
#ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)
configure :development do
    set :database, 'sqlite3:db/development.sqlite'
end 


require_all './app'
require_relative '../lib/holiday_cookies/scraper'