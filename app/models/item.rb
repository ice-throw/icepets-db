class Item < ActiveRecord::Base
    has_one :rarity
    validates :item_id, presence: true
    #validates :name => {:allow_blank => true}
    validates :image_url, :url => {:allow_blank => true}
    
    def self.search(search)
        if search
            @items = Item.where(["name LIKE ?","%#{search}%"])
        else
            all
    end
  end
end
