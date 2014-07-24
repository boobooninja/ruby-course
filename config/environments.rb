if ENV['APP_ENV'] == 'development'
  puts "Using SQL database"
  DoubleDog.db = DoubleDog::Database::SQL.new
else
  puts "Using InMemory database"
  DoubleDog.db = DoubleDog::Database::InMemory.new
end

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'double_dog_dev'
)
