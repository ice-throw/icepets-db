class Wishlist < ActiveRecord::Base
    belongs_to :user
    has_many :wishlist_items
    has_many :items, through: :wishlist_items
    
    attr_accessor :item_list
end
