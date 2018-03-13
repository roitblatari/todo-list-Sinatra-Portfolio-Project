class TodosController < ApplicationController
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
    @todo.save

    redirect "/todos/index"
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
    if logged_in? && current_user
      @user = current_user
      @todo = Todo.find(params[:id])
      @todo.content = params[:content]
      @todo.save
     redirect "/todos/index"
    else
       redirect '/'
    end
  end
end
