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

  get "/todos/edit" do
binding.pry
  end

end
