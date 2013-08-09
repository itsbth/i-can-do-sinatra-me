require 'sinatra'
require 'slim'
require 'sinatra/sequel'

set :views, File.dirname(__FILE__) + '/views'
set :database, ENV['HEROKU_POSTGRESQL_GREEN_URL'] || 'postgres://localhost/icdsm'

migration "create user table" do
  database.create_table :users do
    primary_key :id
    String :wow_name
    String :lol_name
  end
end

class User < Sequel::Model
end

get '/' do
  slim :index, locals: {users: User.all}
end

post '/register' do
  User.create(params)
  redirect '/'
end