require 'debug'
require "awesome_print"

class App < Sinatra::Base

    # Funktion för att prata med databasen
    # Exempel på användning: db.execute('SELECT * FROM fruits')
    def db
      return @db if @db

      @db = SQLite3::Database.new("db/todos.sqlite.db")
      @db.results_as_hash = true

      return @db
    end

    #Routen redirectar till /todos
    get '/' do
      redirect('/todos')
    end

    # Routen hämtar alla todos i databasen
    get '/todos' do
      @todos = db.execute('SELECT * FROM todos')
      p @todos
      erb(:"todos/index")
    end

    #skickar en till ett formulär för att skapa en ny todo
    get '/todos/new' do
      erb(:"todos/new")
    end

    #Routen sparar todon och redirectar sedan till /todos
    post '/todos' do
      p params
      t_name = params["todo_name"]
      t_description = params["todo_description"]
      t_category = params["todo_category"]
      t_priority = params["todo_priority"]

      db.execute("INSERT INTO todos (name, description, category, priority)
      VALUES(?, ?, ?, ?)", [t_name, t_description, t_category, t_priority])
      redirect("/todos")
    end

end
