class Item < ActiveRecord::Base
    has_one :rarity
    has_many :wishlist_items
    has_many :wishlists, through: :wishlist_items
    validates :item_id, presence: true
    validates :image_url, :url => {:allow_blank => true}
    
    def self.search(search)
        if search
            @items = Item.where(["name LIKE ?","%#{search}%"])
            #@items = Item.where(["name LIKE ? AND description is NULL","%#{search}%"])
        else
            Item.last(10).reverse
        end
    end
end
