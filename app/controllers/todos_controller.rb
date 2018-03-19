# require 'sinatra/flash' 
class TodosController < ApplicationController
 
  # use Sinatra::Flash
  get "/todos/index" do
    # binding.pry
    if logged_in?
      @user = current_user
      @todos = current_user.todos
       erb :"/todos/index"
    else
      flash[:message] = "You are not logged in."
      redirect "/"
    end
   
   
  end

  get "/todos/new" do
    @user = current_user
    @todos = current_user.todos
    erb :"/todos/new"
  end

  post '/todo/new' do
    @user = current_user
    # binding.pry
    @todo =  @user.todos.build(content: params[:content])
    # @todos = current_user.todos
    if @todo.save
      redirect "/todos/index"
    else
      # binding.pry
      flash[:message] = "Please fill Out The Input To Create a New ToDo."
      redirect "/todos/index"
    end 

    
  end

  get "/todos/:id/edit" do
    # binding.pry
    if logged_in?
      @user = current_user
      @todo = Todo.find(params[:id])
      erb :"/todos/edit"
    else
      redirect "/"
    end  
  end

  patch "/todos/:id/edit" do
    # binding.pry
    if logged_in? && current_user && params[:content] != ""
      @user = current_user
      @todo = Todo.find(params[:id])
      @todo.content = params[:content]
      @todo.save
     redirect "/todos/index"
    else
       flash[:message] = "Please fill Out The Input To Edit ToDo."
      redirect "/todos/index"
    end
  end

  delete '/todos/:id/delete' do #delete action
    @todo = Todo.find_by_id(params[:id])
    @todo.delete
    redirect "/todos/index"
  end
end
