require './config/environment'
require 'rack-flash'



class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :session_secret, "secret"

  end

  get "/" do
    if logged_in?(session)
      redirect '/beers'
    else
    erb :index
    end
  end

helpers do

  def current_user(session)
  	@user = User.find_by_id(session[:user_id])
  end

  def logged_in?(session)
  	!!session[:user_id]
  end
end

end
