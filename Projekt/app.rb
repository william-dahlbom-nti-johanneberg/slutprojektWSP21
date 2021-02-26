require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'


enable :sessions 

get('/') do 
 slim(:register )
end 


get('/user') do 
 slim(:users)
end 


get('/movies') do

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