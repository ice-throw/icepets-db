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
        @i = 501
        while @i != 1001 do
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
end
