class TodosController < ApplicationController
  get "/todos/index" do

  @todos = current_user.todos
  binding.pry
  erb :"/todos/index"
  end

end
