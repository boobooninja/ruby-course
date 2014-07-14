if ENV['APP_ENV'] == 'development'
  DoubleDog.db = DoubleDog::Database::SQL.new
else
  DoubleDog.db = DoubleDog::Database::InMemory.new
end

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'double_dog_dev'
)
