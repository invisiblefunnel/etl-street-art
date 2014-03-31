require './data/schema.rb'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  @reports = DB[:reports].paginate(params[:page] || 1, 50)
  erb :index
end

get '/:case_id' do
  @report = DB[:reports].where(case_id: params[:case_id]).first
  erb :show
end
