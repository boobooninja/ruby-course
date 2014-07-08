class CreateHonks < ActiveRecord::Migration
  def change
    create_table :honks do |t|
      t.integer :user_id
      # t.references :user
      # t.belongs_to :user
      t.text :content
    end
  end
end
