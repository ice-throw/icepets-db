class AddFreezableToItems < ActiveRecord::Migration
  def change
    add_column :items, :freezable, :boolean
    add_column :items, :openable, :boolean
    add_column :items, :released, :boolean
    add_column :items, :icecash_value, :integer
    add_column :items, :stocks, :integer
    add_column :items, :quest_request, :string
    add_column :items, :quest_prize, :string
  end
end
