require 'sinatra'
require 'omniauth'
require 'omniauth-twitter'

require_relative '/models'

use OmniAuth::Strategies::Twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'

enable :sessions

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end
end

get '/'do
  if current_user
    puts "hi #{current_user.name}"
  else
    redirect '/auth/twitter/'
end

get '/auth/:name/callback' do
  auth = request.env["omniauth.auth"]
  user = User.where(
    uid: auth["uid"],
    nickname: auth["info"]["nickname"],
    name: auth["info"]["name"]
  ).first_or_create

  session[:user_id] = user.id
  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  redirect '/'
end
