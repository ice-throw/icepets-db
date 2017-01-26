class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :item_id, unique: true, null: false
      t.string :name
      t.string :image_url
      t.string :category
      t.integer :rarity_id
      t.integer :value
      t.text :description
      t.date :release_date
      t.date :retirement_date
      t.integer :actual_price, array: true, default: []
      t.text :notes

      t.timestamps null: false
    end
  end
end
