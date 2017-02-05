class AddOpenableToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :openable, :boolean
  end
end
