- Re-design the "Show" page for items.
    - looksdecent, for now
- Link to SS, Quest Item, Add pictures for each quest.
    - I need to check how to add this to the left column.
- Shop that Stocks it
    - I don't know how to automatize this.
- Openable
    - Ask someone to collect these for me. (There's a list but it isn't exclusive to just the openable items.)
- Released
    - If it has a release date, then by default it is released, but I think it would be easier to find all the unreleased items and mark them as so, than to find the release dates of each item. (It it doesn't have a category, then released = false, [that should take care of most of them], if it has a release date, then released = true)
- Ice Cash Value
    - I'm kind of regretting this field haha
- Add previous_image field to model.
    - I need all the old images, for this to be kind of.. reasonable.

- Find a way to exclude stuff from the search results! (ala "-" in Google)

- Edit mode where items without descriptions are presented, and you're redirected to their edit form when you click on it's image. (I haven't done this because I haven't needed it, I also don't know how to add paged navigation for the results.)

- Find a way to add multiple items to a wishlist from a text list
    - Text area, that is later converted to an array using .split("\n")
    - Search items by name, and recover their item_id, when adding them to the join table: top_priority = false, obtained = false, quantity = 1, position = @wishlist.wishlist_items.last.position + 1 (validate if it's nil)
- Find a way to check which items are missing from a certain category when a list is given.
    - Text area, that is later converted to an array using .split("\n")
    - This is the reverse of my Advanced Search method, but.. is the best way creating a loop for each item provided? Seems like that would be a bit too.. heavy on resource use.

- New Years Stamp Description