class InitialSetup < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.boolean :admin
    end

    create_table :sessions do |t|
      t.integer :user_id
    end

    create_table :items do |t|
      t.string :name
      t.string :price
    end

    create_table :orders do |t|
      t.integer :employee_id
    end

    create_table :order_items do |t|
      t.integer :order_id
      t.integer :item_id
    end

  end
end
