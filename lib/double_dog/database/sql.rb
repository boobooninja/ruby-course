module DoubleDog
  module Database
    class SQL

      class User < ActiveRecord::Base
        has_many :orders
      end

      class Session < ActiveRecord::Base
        belongs_to :user
      end

      class OrderItem <ActiveRecord::Base
        belongs_to :order
        belongs_to :item
      end

      class Order < ActiveRecord::Base
        belongs_to :user
        has_many :order_items
        has_many :items, :through => :order_items
      end

      class Item < ActiveRecord::Base
        has_many :order_items
        has_many :orders, :through => :order_items
      end

      def create_user(attrs)
        ar_user = User.create(username: attrs[:username], password: attrs[:password], admin: attrs[:admin])

        DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
      end

      def get_user(id)
        begin
          ar_user = User.find(id)
          DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
        rescue Exception => e
          nil
        end
      end

      def create_session(attrs)
        ar_session = Session.create(user_id: attrs[:user_id])
        ar_session.id
      end

      def get_user_by_session_id(sid)
        ar_session = Session.find(sid)
        return nil if ar_session.id.nil?

        get_user(ar_session.user_id)
      end

      def get_user_by_username(username)
        ar_user = User.where(username: username).take
        return nil if ar_user.nil?
        DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
      end

      def create_item(attrs)
        ar_item = Item.create(name: attrs[:name], price: attrs[:price])
        DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price.to_i)
      end

      def get_item(id)
        ar_item = Item.find(id)
        DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price.to_i)
      end

      def all_items
        ar_items = Item.all
        items = []
        ar_items.each do |ar_item|
          items.push( DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price.to_i) )
        end
        items
      end

      def create_order(attrs)
        ar_order = Order.create(employee_id: attrs[:employee_id])
        items = []
        attrs[:items].each do |item_id|
          ar_item = OrderItem.create(order_id: ar_order.id, item_id: item_id)
          # items.push( DoubleDog::Item.new(item.id, item.name, item.price) )
        end
        items = self.send(:get_order_items, ar_order.id)
        DoubleDog::Order.new(ar_order.id, ar_order.employee_id, items)
      end

      def get_order(id)
        ar_order = Order.find(id)
        items = get_order_items(ar_order.id)
        DoubleDog::Order.new(ar_order.id, ar_order.employee_id, items)
      end

      def all_orders
        ar_orders = Order.all
        orders = []
        ar_orders.each do |ar_order|
          items = get_order_items(ar_order.id)
          orders.push( DoubleDog::Order.new(ar_order.id, ar_order.employee_id, items) )
        end
        orders
      end

      def clear_everything
        User.delete_all
        Order.delete_all
        Item.delete_all
        OrderItem.delete_all
        Session.delete_all
      end

      private

      def get_order_items(order_id)
        ar_order_items = OrderItem.where(order_id: order_id)
        items = []
        ar_order_items.each do |ar_order_item|
          ar_item = Item.find(ar_order_item.item_id)
          items.push( DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price.to_i) )
        end
        items
      end

    end
  end
end
