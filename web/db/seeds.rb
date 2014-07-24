# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require './lib/double_dog.rb'


admin = DoubleDog.db.create_user(username: 'Admin', password: 'pass', admin: true)
user  = DoubleDog.db.create_user(username: 'User', password: 'pass')

pizza = DoubleDog.db.create_item(name: 'Pizza', price: '2.25')
soda  = DoubleDog.db.create_item(name: 'Soda', price: '1.50')

order1 = DoubleDog.db.create_order(employee_id: admin.id, items: [pizza, soda])
order2 = DoubleDog.db.create_order(employee_id: user.id, items: [pizza, soda])
