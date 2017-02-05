class Search < ActiveRecord::Base
    def search_items
		items = Item.all

		items = items.where(["name LIKE ?","%#{keywords}%"]) if keywords.present?
		items = items.where(["category LIKE ?",category]) if category.present?
		items = items.where(["rarity_id LIKE ?",rarity]) if rarity.present?
		items = items.where(["freezable = ?",true]) if freezable.present?
		items = items.where(["openable = ?",true]) if openable.present?
		items = items.where(["value >= ?", min_value]) if min_value.present?
		items = items.where(["value <= ?", max_value]) if max_value.present?
		items = items.where(["description LIKE ?", "%#{description_keywords}%"]) if description_keywords.present?
		items = items.where(["release_date >= ?", min_release_date]) if min_release_date.present?
		items = items.where(["release_date <= ?", max_release_date]) if max_release_date.present?
		items = items.where(["actual_price >= ?", min_price]) if min_price.present?
		items = items.where(["actual_price <= ?", max_price]) if max_price.present?
		return items
	end
end
