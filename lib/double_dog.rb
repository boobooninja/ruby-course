require 'pry-byebug'
require 'active_record'
require 'active_record_tasks'
require 'pg'

module DoubleDog
  def self.db
    @__db_instance
  end

  def self.db=(database)
    @__db_instance = database
  end
end

require_relative 'double_dog/entities/item.rb'
require_relative 'double_dog/entities/user.rb'
require_relative 'double_dog/entities/order.rb'

require_relative 'double_dog/database/in_memory.rb'
require_relative 'double_dog/database/sql.rb'

require_relative 'double_dog/use_cases/create_account.rb'
require_relative 'double_dog/use_cases/create_item.rb'
require_relative 'double_dog/use_cases/sign_in.rb'
require_relative 'double_dog/use_cases/see_all_orders.rb'
require_relative 'double_dog/use_cases/create_order.rb'
require_relative 'double_dog/use_cases/find_order.rb'
require_relative 'double_dog/use_cases/find_user.rb'
require_relative 'double_dog/use_cases/find_order_by_user.rb'

require_relative '../config/environments.rb'
