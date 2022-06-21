# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# unless Rails.env.production?
#   connection = ActiveRecord::Base.connection

#   sql = File.read('db/import.sql') # Change path and filename as necessary
#   statements = sql.split(/;$/)
#   statements.pop
  
#   ActiveRecord::Base.transaction do
#     statements.each do |statement|
#       connection.execute(statement)
#     end
#   end
# end


User.create!([
  { name: 'test1', email: 'test1@example.com', password: 'qwer1234' },
  { name: 'test2', email: 'test2@example.com', password: 'qwer1234' },
  { name: 'test3', email: 'test3@example.com', password: 'qwer1234' },
  { name: 'test4', email: 'test4@example.com', password: 'qwer1234' },
  { name: 'test5', email: 'test5@example.com', password: 'qwer1234' },
  { name: 'test6', email: 'test6@example.com', password: 'qwer1234' },
  { name: 'test7', email: 'test7@example.com', password: 'qwer1234' },
  { name: 'test8', email: 'test8@example.com', password: 'qwer1234' },
  { name: 'test9', email: 'test9@example.com', password: 'qwer1234' },
  { name: 'test10', email: 'test10@example.com', password: 'qwer1234' },
  { name: 'test11', email: 'test11@example.com', password: 'qwer1234' }
])