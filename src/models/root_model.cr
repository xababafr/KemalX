require "db"
require "sqlite3"

class RootModel < KemalX::Model

  def self.create
    DB.open "sqlite3:./src/models/dbs/names.db" do |db|
      # When using the pg driver, use $1, $2, etc. instead of ?
      db.exec "create table contacts (name text, age integer)"
      db.exec "insert into contacts values (?, ?)", "John Doe", 30
      db.exec "insert into contacts values (?, ?)", "Alex Tornson", 28
      db.exec "insert into contacts values (?, ?)", "Yolo Diver", 59
    end
  end

  def self.get_names

    names = [] of Array(String | Int32)
    DB.open "sqlite3:./src/models/dbs/names.db" do |db|
      db.query "select name, age from contacts order by age desc" do |rs|
        puts "#{rs.column_name(0)} (#{rs.column_name(1)})"
        # => name (age)
        rs.each do
          names << [rs.read(String), rs.read(Int32)]
          # => Sarah (33)
          # => John Doe (30)
        end
      end
    end
    names

  end

end
