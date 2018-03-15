require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get "/" do
  # binding.pry
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
 
    def log_out
        session.destroy
        @current_user = nil
    end
  end
end
