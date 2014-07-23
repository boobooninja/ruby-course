require './lib/double_dog.rb'


admin = DoubleDog.db.create_user(username: 'Admin', password: 'pass', admin: true)
user  = DoubleDog.db.create_user(username: 'User', password: 'pass')

pizza = DoubleDog.db.create_item(name: 'Pizza', price: '2.25')
soda  = DoubleDog.db.create_item(name: 'Soda', price: '1.50')

order1 = DoubleDog.db.create_order(employee_id: admin.id, items: [pizza, soda])
order2 = DoubleDog.db.create_order(employee_id: user.id, items: [pizza, soda])
