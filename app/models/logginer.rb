class Logginer
    attr_accessor :agent, :login_page_user, :login_form_user, :user_field, :login_page_pass, :login_form_pass, :password_field, :home_page

    def login(url, password)
        begin
            self.agent = Mechanize.new
            self.agent.log = Logger.new "mechanize.log"
            self.login_page_user = agent.get url
            self.login_form_user = self.login_page_user.form_with(action: 'login.php')
            self.user_field = self.login_form_user.field_with(name: "login_username")
            self.user_field.value = 'Fenix'
            self.login_page_pass = self.login_form_user.click_button
            self.login_form_pass = self.login_page_pass.form_with(action: 'login.php?')
            self.password_field = self.login_form_pass.field_with(name: "login_pass")
            self.password_field.value = password
            self.home_page = self.login_form_pass.click_button
            
        rescue Exception => e
            puts e.message
            puts e.backtrace.inspect
        end
    end
    
    def loop_test 
        $i = 0
        $num = 5
        
        while $i != $num  do
           puts("Inside the loop i = #$i" )
           $i +=1
        end
    end
    
    def save_test(pass)
        self.login("http://www.icepets.com/login.php", pass)
        @i = 3805
        while @i != 3808 do
            #ehh, I should use some kind of begin 
            self.home_page = agent.get "http://www.icepets.com/shops.php?viewshop=9&i=" + @i.to_s + "&p=258&buyitem=conf&type=" 
            t = Item.new
            t.item_id = @i
            #if self.home_page.at('.tablecontent strong').text.strip == 
            test = self.home_page.at('.tablecontent strong').text 
            if self.home_page.at('.tablecontent strong') != nil or self.home_page.at('.tablecontent strong').text != ""
                t.name = self.home_page.at('.tablecontent strong').text.strip 
            else
                t.name = nil
            end
            t.image_url = "http://www.icepets.com/" + self.home_page.at('.tablecontent img').values[0].sub("..","") # I know there's easier ways to do this, I'm kind of just trying to learn.
            #if t.name != nil or t.name != ""
            if test != ""
                self.home_page = agent.get "http://www.icepets.com/search.php?q=" + t.name
                #t.category = self.home_page.at('center > table > tr').text.sub(t.name + "Category: ","").split(" ")[0].sub("Value:","")
                searchable = self.home_page.at('div#'+t.item_id.to_s)
                if searchable != nil
                    t.category = self.home_page.at('div#'+t.item_id.to_s).text.sub("Category: ","").split(" ")[0].sub("Value:","")
                    if t.category == "Ice"
                        t.category = "Ice Cube"
                    elsif t.category == "Battle"
                        t.category = "Battle Item"
                    elsif t.category == "Special"
                        t.category = "Special Event"
                    end
                    #t.value = self.home_page.at('center > table > tr').text.sub(t.name + "Category: "+t.category,"").split(" ")[1].sub(",","").to_i
                    t.value = self.home_page.at('div#'+t.item_id.to_s).text.sub("Category: "+t.category,"").split(" ")[1].sub(",","").to_i
                    #t.rarity_id = self.home_page.at('center > table > tr').text.sub(t.name + "Category: "+t.category,"").split(" ")[3].to_i
                    t.rarity_id = self.home_page.at('div#'+t.item_id.to_s).text.sub("Category: "+t.category,"").split(" ")[3].sub(",","").to_i
                    if t.rarity_id == 7
                        t.retirement_date = "2000-1-1".to_date
                    end
                    t.save
                else
                    t.save
                end
            else
                t.save
            end
            
            @i +=1
        end
    end
    
    def single_test(pass, i)
        self.login("http://www.icepets.com/login.php", pass)
        self.home_page = agent.get "http://www.icepets.com/shops.php?viewshop=9&i=" + @i.to_s + "&p=258&buyitem=conf&type="
        t = Item.new
        if self.home_page.at('.tablecontent strong') != nil
            t.name = self.home_page.at('.tablecontent strong').text.strip 
        end
        t.image_url = "http://www.icepets.com/" + self.home_page.at('.tablecontent img').values[0].sub("..","")
        self.home_page = agent.get "http://www.icepets.com/search.php?q=" + t.name
    end
    
    def save_quest
        array = ["60s Ice Cube", "Birthday Cake Ice Cube", "Blackberry Slushie", "Blue Ice Cube", "Blue Snow Jar Ice Cube", "Blueberry Ice Cream Cone Plushie", "Blueberry Smoothie", "Blueberry Swirl Ice Cream", "Book of Ice", "Brown Ice Cube", "Butterscotch Swirl Ice Cream Cone Plushie", "Chefs Hat Ice Cube", "Cherry Smoothie", "Chocolate Ice Cream", "Chocolate Smoothie", "Chocolate Swirl Ice Cream Cone Plushie", "Cottoncandy Snow Cone", "Explosive Ice Cube", "Flower Ice Cube", "Frozen Cream of Mushroom Soup", "Galaxy Ice Cube", "Golden Ice Cube", "Grape Slushie", "Grape Snow Soda", "Green Ice Cube", "Green Token Ice Cube", "Ice Apple", "Ice Buckler", "Ice Cubes and You!", "Ice Dovu Plushie", "Ice Hat", "Ice Lipstick", "Ice Ori Plushie", "Ice Ridix Stamp", "Ice Sharshel Plushie", "Ice Snowball", "Ice Traptur Plushie", "Ice Wulfer Plushie", "Lemon Lime Smoothie", "Lemon Snow Cone", "Lime Slushie", "Math Ice Cube", "Mint Ice Cream", "Mocha Smoothie", "Orange Ice Pop", "Orange Slushie", "Orange Snow Jar Ice Cube", "Pink Ice Cube", "Pirate Hat Ice Cube", "Pumpkin Smoothie", "Purple Snow Jar Ice Cube", "Rainbow Hipster Glasses Ice Cube", "Rainbow Smoothie", "Red Apple Ice Cube", "Red Ice Cube", "Royal Ice Cube", "Shuriken Ice Cube", "Smiley Ice Cube", "Strawberry Ice Cream", "Strawberry Smoothie", "Tropical Cooler Smoothie", "Vanilla Ice Cream Cone Plushie", "Watermelon Smoothie", "Yellow Ice Cube", "Yellow Token Ice Cube", "Banana Ice Cube", "Black Ice Cube", "Blackberry Smoothie", "Blue Makoat Ice Cube", "Blue Token Ice Cube", "Blueberry Ice Pop", "Blueberry Snow Cone", "Blueberry Swirl Ice Cream Cone Plushie", "Bronze Ice Cube", "Brown Snow Jar Ice Cube", "Caramel Smoothie", "Cherry Ice Cube", "Cherry Snow Cone", "Chocolate Ice Cream Cone Plushie", "Chocolate Snot Snow Cone", "Cottoncandy Dabu Ice Cube", "Cottoncandy Snow Jar Ice Cube", "Fish Ice Cube", "Frozen Book", "Frozen Egg Drop Soup", "Gold Star Ice Cube", "Grape Ice Cube", "Grape Smoothie", "Green Apple Popsicle", "Green Sharshel Ice Cube", "Grey Snow Jar Ice Cube", "Ice Audril Plushie", "Ice Cobron Plushie", "Ice Cubes Stamp", "Ice Fireball", "Ice Jacket", "Ice Makoat Plushie", "Ice Perfume", "Ice Shard Stamp", "Ice Snow Jar", "Ice Stamp", "Ice Trido Plushie", "Kiwi Snow Soda", "Lemon Lime Snow Cone", "Lemon Snow Soda", "Lime Snow Cone", "Melon Smoothie", "Mint Ice Cream Cone Plushie", "Mystery Snow Soda", "Orange Ori Ice Cube", "Orange Smoothie", "Orange Snow Soda", "Pink Lemonade Popsicle", "Plain Ice Cube", "Purple Ice Cube", "Purple Token Ice Cube", "Rainbow Ice Cube", "Raspberry Slushie", "Red Audril Ice Cube", "Red Snow Jar Ice Cube", "Rubber Ice Sword", "Silver Ice Cube", "Snowdrift Snow Jar Ice Cube", "Strawberry Ice Cream Cone Plushie", "Strawberry Swirl Ice Cream", "Unflavored Snow Soda", "Vanilla Smoothie", "White Snow Jar Ice Cube", "Yellow Jakrit Ice Cube", "Banana Popsicle", "Black Snow Jar Ice Cube", "Blackberry Snow Cone", "Blue Raspberry Popsicle", "Blueberry Ice Cream", "Blueberry Slushie", "Blueberry Snow Soda", "Bluegreen Trido Ice Cube", "Bronze Token Ice Cube", "Butterscotch Swirl Ice Cream", "Cheese Ice Cube", "Cherry Slushie", "Cherry Snow Soda", "Chocolate Ice Cube", "Chocolate Swirl Ice Cream", "Cottoncandy Slushie", "Eat Ice", "Fish Slushie", "Frozen Chicken Noodle Soup", "Frozen Potato Soup", "Gold Token Ice Cube", "Grape Ice Pop", "Grape Snow Cone", "Green Cobron Ice Cube", "Green Snow Jar Ice Cube", "Half Eaten Ice Cube", "Ice Bomb", "Ice Cube Necklace", "Ice Dabu Plushie", "Ice Fondue", "Ice Jakrit Plushie", "Ice Novyn Plushie", "Ice Ridix Plushie", "Ice Sharshel Hat", "Ice Snow Jar Ice Cube", "Ice Sword", "Ice Wand", "Lemon Ice Pop", "Lemon Smoothie", "Lime Ice Pop", "Mammoth Ice Cube", "Melting Ice Cube", "Mixed Berry Smoothie", "Orange Ice Cube", "Orange Ridix Ice Cube", "Orange Snow Cone", "Orange Token Ice Cube", "Pink Snow Jar Ice Cube", "Platinum Token Ice Cube", "Purple Novyn Ice Cube", "Rainbow Hairbrush Ice Cube", "Rainbow Ice Pop", "Raspberry Snow Cone", "Red Dovu Ice Cube", "Red Token Ice Cube", "Shopping Ice Cube", "Silver Token Ice Cube", "Staff Ice Cube", "Strawberry Ice Pop", "Strawberry Swirl Ice Cream Cone Plushie", "Vanilla Ice Cream", "Watermelon Slice Popsicle", "White Traptur Ice Cube", "Yellow Snow Jar Ice Cube"]
        @j = 0
        while @j <= array.size do
            l = Item.find_by_name(array[@j])
            if l.quest_request == nil
                l.quest_request = "13"
            else
                l.quest_request = l.quest_request + " 13"
            end
            l.save
            @j +=1
        end
    end
    
    def save_freezable
        array = ["Black Snow Jar ", "Blue Snow Jar ", "Bluegreen Snow Jar ", "Cottoncandy Snow Jar ", "Green Snow Jar ", "Grey Snow Jar ", "Orange Snow Jar ", "Pink Snow Jar ", "Purple Snow Jar ", "Red Snow Jar ", "Snowdrift Snow Jar ", "White Snow Jar ", "Yellow Snow Jar ", "60s Snow Jar ", "Ancient Snow Jar ", "Angelic Snow Jar ", "Baby Snow Jar ", "Brown Snow Jar ", "Christmas Snow Jar ", "Crystal Snow Jar ", "Evil Snow Jar ", "Fairy Snow Jar ", "Firebreathing Snow Jar ", "Flying Snow Jar ", "Love Snow Jar ", "Party Snow Jar ", "Pinata Snow Jar ", "Plushie Snow Jar ", "Prankster Pie ", "Rave Snow Jar ", "Space Snow Jar ", "Tech Snow Jar ", "Woodland Snow Jar ", "Halloween Snow Jar ", "Ice Snow Jar ", "Pirate Snow Jar ", "Rainbow Snow Jar ", "Skeletal Snow Jar ", "Storm Snow Jar ", "Blue Token ", "Green Token ", "Orange Token ", "Purple Token ", "Red Token ", "Yellow Token ", "Bronze Token ", "Gold Token ", "Silver Token ", "Platinum Token ", "60s Jakrit Egg ", "Ancient Jakrit Egg ", "Angelic Jakrit Egg ", "Blue Jakrit Egg ", "Blue Makoat Jakrit Egg ", "Circles Jakrit Egg ", "Diamond Jakrit Egg ", "Earth Jakrit Egg ", "Elements Jakrit Egg ", "Evil Jakrit Egg ", "Fire Jakrit Egg ", "Flying Jakrit Egg ", "Frozen Jakrit Egg ", "Galaxy Jakrit Egg ", "Gift Wrapped Jakrit Egg ", "Glowing Jakrit Egg ", "Green Ridix Jakrit Egg", "Heart Jakrit Egg ", "Ice Jakrit Egg ", "I.C.E Jakrit Egg ", "Jigsaw Jakrit Egg ", "Mini Jakrit Egg ", "Ninja Jakrit Egg ", "Party Jakrit Egg ", "Pink Sharshel Jakrit Egg ", "Pirate Jakrit Egg ", "Polka Dot Jakrit Egg ", "Purple Swirl Jakrit Egg ", "Rainbow Jakrit Egg ", "Red Dabu Jakrit Egg ", "Snowdrift Jakrit Egg ", "Stars Jakrit Egg ", "Wind Jakrit Egg ", "Vortex Jakrit Egg ", "Yellow Jakrit Jakrit Egg ", "Birthday Cake ", "Birthday Cupcakes ", "Brain Cupcake ", "Yule Log ", "Rainbow Hairbrush ", "Rainbow Hipster Glasses ", "Chefs Hat ", "Baby Shoes ", "Egg Pull Toy ", "Team Blue Audril Flag ", "Team Green Trido Flag ", "Team Red Dovu Flag ", "Team Yellow Sharshel Flag ", "Single Red Rose ", "Treasure Chest "]
        @j = 0
        while @j < array.size do
            l = Item.find_by_name(array[@j].strip)
            l.freezable = true
            l.save
            @j +=1
        end
    end
    
    def move_item(pass)
        self.login("http://www.icepets.com/login.php", pass)
        self.home_page = agent.get "http://www.icepets.com/items_storage.php?view=11398"
        links = self.home_page.links_with(:text => "[move]")
        @k = 0
        while @k < links.size do
            self.home_page = agent.get links[@k].uri.to_s
            puts self.home_page.uri
            self.home_page.forms.second.click_button
            @k +=1
        end
    end
    
    def save_description(pass)
        #self.login("http://www.icepets.com/login.php", pass)
        self.home_page = agent.get "http://www.icepets.com/inventory.php"
        links = self.home_page.links_with(:href => %r{inventory_use.php})
        @l = 0
        while @l < links.size do
            self.home_page = agent.get links[@l].uri.to_s
            name = self.home_page.at('div.tableoutline strong').text.strip
            description = self.home_page.at('div.tableoutline span').text.gsub("\n", "")
            i = Item.find_by_name(name)
            i.description = description
            i.save
            @l +=1
        end
    end
    
    #1344
    #1394
    #1436
    #1529
    #1573
end
