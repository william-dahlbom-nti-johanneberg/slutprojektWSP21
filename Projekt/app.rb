require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'


enable :sessions 

get('/') do 
 slim(:register )
end 

get('/showlogin') do 
 slim(:login)
end

post('/login') do 
  username = params[:username]
  password = params[:password]
  db = SQLite3::Database.new('db/database1.db')
  db.results_as_hash = true
  result = db.execute("SELECT * FROM users WHERE user_name = ?",username).first
  pwdigest = result["pwdigest"]
  id = result["id"]
  if BCrypt::Password.new(pwdigest) == password
    session[:id] = result["id"]
    redirect('/user')
  else
    "ICKE MATCHANDE LÖSENORD"
  end
end

post('/users/new') do
  username = params[:username]
  password = params[:password]
  password_confirm = params[:password_confirm]
  
  if (password == password_confirm)
    password_digest = BCrypt::Password.create(password)
    db = SQLite3::Database.new('db/database1.db')
    db.execute("INSERT INTO users (username,password) VALUES (?,?)",username,password_digest)
    redirect('/')

  else
#Något om att man inte får ha samma användarnamn som någon annan och att lösenordet stämmer överrens med password_confirm
  end
end

get('/user') do
  id = session[:id].to_i
  db = SQLite3::Database.new('db/database1.db')
  db.results_as_hash = true
  result = db.execute("SELECT * FROM users WHERE user_id = ?",id)
  slim(:"users",locals:{users:result})
end


get('/user/movies/new') do 

end 

post('/user/movies/:id/delete') do 

end 


post('/user/movies/:id/update') do 

end 


get('/movies') do
  slim(:movies)
 end


