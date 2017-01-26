module ItemsHelper
    def show(item)
        if item.name == nil or item.name == ""
            link_to 'Show', show_item_path(item)
        else
            link_to 'Show', show_item_path(item.name)
        end
    end
    
    def check_retirement_date(item)
        if item.rarity_id == nil
            "?"
        elsif item.rarity_id != 7
            "Not Retired"
        elsif item.retirement_date == "2000-1-1".to_date && item.rarity_id == 7
            "Unknown"
        else
            return item.retirement_date
        end
    end
    
    def check_rarity(item)
        if item.rarity_id != nil
            Rarity.find(item.rarity_id).name
        end
    end
end
