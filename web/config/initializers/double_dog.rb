require '../lib/double_dog.rb'
# create an admin user and login and store the session as global variable
admin = DoubleDog.db.get_user_by_username('admin')
unless admin
  admin = DoubleDog.db.create_user(username: 'admin', password: 'pass', admin: true)
end
session = DoubleDog::SignIn.new.run({username: 'admin', password: 'pass'})
SESSION_ID = session[:session_id]
