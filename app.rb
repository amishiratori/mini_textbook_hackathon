require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/answer.rb'
require 'csv'

use Rack::Session::Cookie

get '/' do
  erb :index
end

post '/confirm' do
  session[:name] = params[:name]
  session[:snack] = params[:snack]
  redirect '/confirm'
end
 
get '/confirm' do
  @name = session[:name]
  @snack = session[:snack]
  erb :confirm
end

post '/new' do
  Answer.create({
    name: session[:name],
    snack: session[:snack]
    })
  redirect '/finish'
end

get '/finish' do
  if Answer.find_by(snack: 'KINOKO').present?
    @kinoko = Answer.where(snack: 'KINOKO').length.to_f
  else
    @kinoko = 0
  end
  
  if Answer.find_by(snack:'TAKENOKO').present?
    @takenoko = Answer.where(snack: 'TAKENOKO').length.to_f
  else
    @takenoko = 0
  end
  
  @all = Answer.all.length.to_f
  
  erb :finish
end

get '/list' do
  @answers = Answer.all
  erb :list
end
