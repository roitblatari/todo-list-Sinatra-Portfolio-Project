# require 'sinatra/flash' 
class TodosController < ApplicationController
 
  # use Sinatra::Flash
  get "/todos/index" do
    @user = current_user
    @todos = current_user.todos
    erb :"/todos/index"
  end

  get "/todos/new" do
    @user = current_user
    @todos = current_user.todos
    erb :"/todos/new"
  end

  post '/todo/new' do
    @user = current_user
    # binding.pry
    @todo = Todo.new(content: params[:content], user_id: @user.id)
    # @todos = current_user.todos
    if @todo.save
      redirect "/todos/index"
    else
      # binding.pry
      # flash[:message] = "Please fill out the full form."
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
       redirect '/'
    end
  end

  delete '/todos/:id/delete' do #delete action
    @todo = Todo.find_by_id(params[:id])
    @todo.delete
    redirect "/todos/index"
  end
end
