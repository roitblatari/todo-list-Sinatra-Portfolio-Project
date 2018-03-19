

class UsersController < ApplicationController
  

  get "/users/new" do
    if logged_in?
      redirect "/todos/index"
    else
      # biqnding.pry
      erb :'/users/new'
    end
  end

  post '/users' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password] )
    if @user.save 
      binding.pry
      session[:user_id] = @user.id
      # binding.pry
      redirect "/users/#{@user.slug}"
    else
      # binding.pry
      flash[:message] = "Could not save User, Please fill out the FULL form"
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

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"      
    else
      flash[:message] = "Sorry, Check Your Username or Password and Try Again"
       redirect "/"
    end
  end

  get "/users/logout" do
    session.destroy
    @current_user = nil
    redirect "/"
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

   

end
