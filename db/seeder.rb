require 'sqlite3'
require_relative '../config'

class Seeder

  def self.seed!
    puts "Using db file: #{'db/todos.sqlite.db'}"
    puts "🧹 Dropping old tables..."
    drop_tables
    puts "🧱 Creating tables..."
    create_tables
    puts "🍎 Populating tables..."
    populate_tables
    puts "✅ Done seeding the database!"
  end

  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS todos')
  end

  def self.create_tables
    db.execute('CREATE TABLE todos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                category_id INTEGER 
                description TEXT)')
  end

  def self.populate_tables
    db.execute('INSERT INTO todos (name, description, category, priority) VALUES ("Köp mjölk", "3 lite mellanmjölk, eko", inköp, 1)')
    db.execute('INSERT INTO todos (name, description, category, priority) VALUES ("Köp julgran", "En rödgran", inköp, 1)')
    db.execute('INSERT INTO todos (name, description, category, priority) VALUES ("Pynta gran", "Glöm inte lamporna i granen och tomten", övrigt, 1)')
  end

  private

  def self.db
    @db ||= begin
      db = SQLite3::Database.new('db/todos.sqlite.db')
      db.results_as_hash = true
      db
    end
  end

end

Seeder.seed!