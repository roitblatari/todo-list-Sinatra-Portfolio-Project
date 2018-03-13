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
    @todos = current_user.todos
    @todos.save
    redirect "/todos/index"
  end

end
