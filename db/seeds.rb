      user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
      todo1 = Todo.create(:content => "todoing!", :user_id => user.id)
      todo2 = Todo.create(:content => "todo this", :user_id => user.id)

      sara = User.create(:username => "sara", :email => "sara@aol.com", :password => "12345678")
      sara1 = Todo.create(:content => "todo things!", :user_id => user.id)
      sara2 = Todo.create(:content => "clean ....", :user_id => user.id)

      zac = User.create(:username => "zac", :email => "zac@aol.com", :password => "12345678")
      zac1 = Todo.create(:content => "todo things!", :user_id => user.id)
      zac2 = Todo.create(:content => "clean ....", :user_id => user.id)