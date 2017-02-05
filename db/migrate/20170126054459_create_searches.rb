class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :keywords
      t.string :category
      t.integer :rarity
      t.integer :min_value
      t.integer :max_value
      t.text :description_keywords
      t.date :min_release_date
      t.date :max_release_date
      t.integer :min_price
      t.integer :max_price

      t.timestamps null: false
    end
  end
end
