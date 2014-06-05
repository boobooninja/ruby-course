require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items

  def initialize(name)
    @name           = name
    @menu_items     = [ ]
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    menu_items << MenuItem.new(name, price)
  end

  def happy_hour?
    hour = Time.now.hour
    minute = Time.now.min

    hour >= 15 && hour < 16 ||
    hour == 16 && minute == 0
  end

  def happy_discount
    happy_hour? ? @happy_discount : 0
  end

  def happy_discount=(discount)
    @happy_discount = if discount > 1
                        1
                      elsif discount < 0
                        0
                      else
                        discount
                      end
  end
end

class MenuItem
  attr_reader :name, :price

  def initialize(name, price)
    @name  = name
    @price = price
  end
end
