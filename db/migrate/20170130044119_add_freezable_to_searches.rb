class AddFreezableToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :freezable, :boolean
  end
end
