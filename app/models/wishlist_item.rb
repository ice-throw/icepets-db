class WishlistItem < ActiveRecord::Base
    validates_uniqueness_of :item_id, :scope => :wishlist_id
end
