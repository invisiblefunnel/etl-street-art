require './data/schema.rb'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  @reports = DB[:reports].paginate(params[:page] || 1, 50)
  erb :index
end
