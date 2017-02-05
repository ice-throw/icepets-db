class CreateWishlistItems < ActiveRecord::Migration
  def change
    create_table :wishlist_items do |t|
      t.integer :wishlist_id
      t.integer :item_id
      t.integer :quantity
      t.integer :position
      t.boolean :top_priority
      t.boolean :obtained

      t.timestamps null: false
    end
  end
end
