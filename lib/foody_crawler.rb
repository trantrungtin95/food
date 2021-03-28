class FoodyCrawler
    # lists all attrubutes of foody table
    def self.create_restaurant
        
        Selenium::WebDriver::Chrome.path = "/app/.apt/usr/bin/google-chrome"
        Selenium::WebDriver::Chrome.driver_path = "/app/bin/chromedriver"
        
        @browser = Watir::Browser.new:chrome
        @browser.goto 'https://www.now.vn/ho-chi-minh/food/deals'
        sleep 5
        hrefs = []
        @browser.as(class: 'item-content').to_a.each do |a_tag|
            a_tag.href
            hrefs.push(a_tag.href)
        end
        puts(hrefs)
        hrefs.each do |href|
            @browser.goto(href)
            
            name_tag =  @browser.h1(class: 'name-restaurant')
            restaurant_name = name_tag.text
            
            time = @browser.div(class: 'time').text
            open_time = time.split('-')[0]
            close_time = time.split('-')[1]
            
            address_tag = @browser.div(class: 'address-restaurant')
            address = address_tag.text
            
            latitude = Geocoder.search(address).first.coordinates[0]
            longitude = Geocoder.search(address).first.coordinates[1]
            
            restaurant = Restaurant.create( name: restaurant_name, 
                user_id: 1, 
                address: address, 
                open_time: open_time,
                close_time: close_time,
                latitude: latitude,
                longitude: longitude 
            )
        end
    end
    
    def self.create_food

        Selenium::WebDriver::Chrome.path = "path/to/google-chrome"
        Selenium::WebDriver::Chrome.driver_path = "path/to/chromedriver"

        @browser = Watir::Browser.new:chrome
        @browser.goto 'https://www.now.vn/ho-chi-minh/mon-quang-xuyen-viet'
        @browser.divs(class: 'item-restaurant-row').to_a.each do |e|
            name_food = e.img.alt
            img_url = e.img.src
            price_food = e.div(class: 'current-price').text.to_d
            food = Dish.create(   name: name_food,
                                        image_url: img_url,
                                        price: price_food, 
                                        user_id: 1, 
                                        restaurant_id: 2
                                        )
        end
    end 
end