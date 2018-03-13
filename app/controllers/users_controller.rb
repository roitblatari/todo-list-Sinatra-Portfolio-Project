class UsersController < ApplicationController
  
  get "/users/new" do
    if !!logged_in?
      erb :"/users/login"
    else
      erb :'/users/new'
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

  post '/users' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password] )
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      # binding.pry
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
      erb :"/users/show"
    end
  end
end
