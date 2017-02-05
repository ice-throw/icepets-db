module WishlistsHelper
    def get_image(id)
        i = Item.find_by_id(id)
        link_to image_tag(i.image_url), "../items/"+i.name
    end
    
    def get_name(id)
        i = Item.find_by_id(id)
        link_to i.name, "../items/"+i.name
    end
end
