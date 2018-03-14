# require 'sinatra/flash'
class UsersController < ApplicationController
  # use Sinatra::Flash

  get "/users/new" do
    if !!logged_in?
      redirect "/todos/index"
    else
      erb :'/users/new'
    end
  end

  post '/users' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password] )
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      # binding.pry
      # flash[:message] =  "Could not save User, Please fill out the full form "
      redirect "/"
    end
  end

  get "/users/login" do
    if !logged_in?
      erb :"/users/login"
    else
      redirect "/todos/index"
    end
  end

  post "/users/login" do
     @user = User.find_by_slug(params[:slug])
    if @user
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"      
    else
       redirect "/"
    end
  end

  get "/users/:slug" do
    # binding.pry
    @user = User.find_by_slug(params[:slug])
    if @user != current_user
      redirect "/users/#{current_user.slug}"
    else
      # binding.pry
      @todos = @user.todos
      redirect "/todos/index"
    end
  end

   get "/users/logout" do
    # binding.pry
      @user = User.find_by_slug(params[:slug])
      if logged_in?
        session.destroy
        @current_user = nil
        erb :"/index"
      else
        erb :"/index"
      end
   end

end
