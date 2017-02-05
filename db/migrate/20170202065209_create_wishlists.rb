class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.string :name
      t.text :description
      t.string :privacy
      t.string :sorting
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
