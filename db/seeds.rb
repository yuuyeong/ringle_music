# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
unless Rails.env.production?
  connection = ActiveRecord::Base.connection

  sql = File.read('db/import.sql') # Change path and filename as necessary
  statements = sql.split(/;$/)
  statements.pop
  
  ActiveRecord::Base.transaction do
    statements.each do |statement|
      connection.execute(statement)
    end
  end
end


Vehicle.create!([
  { name: 'Tesla Model S', price: '51885.17', picture: 'https://static-assets.tesla.com/configurator/compositor?&options=$MT337,$PPSW,$W40B,$IBB1&view=STUD_FRONT34&model=m3&size=1920&bkba_opt=2&version=v0028d202109300916&crop=0,0,0,0&version=v0028d202109300916' },
  { name: 'Tesla Model 3', price: '100990', picture: 'https://static-assets.tesla.com/configurator/compositor?&options=$MTS10,$PPSW,$WS90,$IBE00&view=FRONT34&model=ms&size=1920&bkba_opt=2&version=v0028d202109300916&crop=0,0,0,0&version=v0028d202109300916' },
  { name: 'Tesla Model X', price: '120990', picture: 'https://static-assets.tesla.com/configurator/compositor?&options=$MTX10,$PPSW,$WX00,$IBE00&view=FRONT34&model=mx&size=1920&bkba_opt=2&version=v0028d202109300916&crop=0,0,0,0&version=v0028d202109300916' },
  { name: 'Tesla Model Y', price: '65000', picture: 'https://static-assets.tesla.com/configurator/compositor?&options=$MTY07,$PPSW,$WY19B,$INPB0&view=FRONT34&model=my&size=1920&bkba_opt=2&version=v0028d202109300916&crop=0,0,0,0&version=v0028d202109300916' }
])