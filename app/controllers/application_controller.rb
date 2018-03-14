require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #unless test?
    set :session_secret, "secret"
  end

  get "/" do
    # binding.pry
    # log_out
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
