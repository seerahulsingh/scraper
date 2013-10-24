namespace :scrape do
  desc "Fill database with zabihah restaurant data"

  task zabihah: :environment do
    require 'rubygems'
    require 'mechanize'
    require 'nokogiri'
    require 'open-uri'
    require 'geocoder'

    agent = Mechanize.new
    agent.open_timeout   = 50
    agent.read_timeout   = 50
    page = agent.get("http://www.zabihah.com/b/United-States+125")
    cities = []
    count = 1
    page.links_with(:href => /^\/b\d*/).each do |cities_link|
       cities << cities_link.text 
    end
    cities = cities[38..cities.length]
    puts cities
    cities.each do |city|
        page.links_with(:text => "#{city}", :href => /^\/b\d*/).each do |b_link|
            # begin
                b_link.click
                c_page = agent.page
                puts b_link.href
                puts "\n\n"

                c_page.links_with(:href => /^\/c\d*/).each do |c_link|
                    # begin
                        c_link.click
                        d_page = agent.page
                        puts c_link.href
                        puts "\n\n"

                        lnk = []
                        d_page.links_with(:href => /^http:\/\/www.zabihah.com\/d\d*/).each { |l| lnk << l.href }
                        lnk.uniq! 
                        lnk2 = lnk[0...lnk.length-11]
                        
                        lnk2.each do |d_link|
                            begin
                                save_restaurants(d_page,d_link,agent,page)
                                puts count
                                count += 1
                            rescue
                            end
                        end

                        puts "\n\n"
                    # rescue
                    # end
                end

                c_page.links_with(:href => /^\/b\d*/).each do |b2_link|
                    # begin
                        b2_link.click
                        c2_page = agent.page
                        puts b2_link.href
                        puts "\n\n"

                        c2_page.links_with(:href => /^\/c\d*/).each do |c2_link|
                            # begin
                                c2_link.click
                                d2_page = agent.page
                                puts c2_link.href
                                puts "\n\n"

                                lnk = []
                                d2_page.links_with(:href => /^http:\/\/www.zabihah.com\/d\d*/).each { |l| lnk << l.href }
                                lnk.uniq! 
                                lnk2 = lnk[0...lnk.length-11]
                            
                                lnk2.each do |d2_link|
                                    begin
                                        save_restaurants(d2_page,d2_link,agent,page)
                                        puts count 
                                        count += 1
                                    rescue
                                    end
                                  
                                end

                                puts "\n\n"
                            # rescue
                            # end
                        end
                    # rescue
                    # end
                end
            # rescue
            # end
        end
    end

  end

    task delete: :environment do
        Restaurant.where("flag = ?","zabihah").destroy_all
    end

    def save_restaurants(d_page,d_link,agent,page)
        puts d_link
        puts "\n"
        
        d_page.link_with(:href=>"#{d_link}").click

        
        r_page = agent.page
        r_url = r_page.uri

        page2 = Nokogiri::HTML(open(r_url))


        name = page2.css('.titleBM')[0]
        if name != nil
            name = name.text
            addr = page2.css('.titleBM')[0].parent.text
        elsif page2.css('.sysTitleL')[0] != nil
            name = page2.css('.sysTitleL')[0].text
            addr = page2.css('.sysTitleL')[0].parent.text
        else
            
        end
        info = []

        address = addr.gsub!(name,"")
        striped_address = strip_or_self!(address)
        zipcode = striped_address.split(//).last(5).join("").to_s
        address = address + ", USA"

        puts "\n\n"

        results = Geocoder.search(address)
        puts district = results[0].city
        puts city = results[0].state
        puts results[0].country
        puts results[0].postal_code
        address = results[0].address
        
        short_address = address.split(",")
        short_address = short_address[0].to_s
        puts short_address
        puts "\n\n"

        desc = page2.xpath("//html/body/table[4]/tr[1]/td[1]/table[1]/tr[1]/td[1]/font[1]/preceding-sibling::text()").to_s
        description = strip_or_self!(desc)
        puts info << name << address << description
        puts "zipcode : #{zipcode}"
        puts "\n"

        info.each { |str| str.encode!('utf-8', :invalid => :replace, :undef => :replace)  }
        zipcode.encode!('utf-8', :invalid => :replace, :undef => :replace)

        map = page2.xpath("/html/body/table[4]/tr/td/table/tr/td/table[4]/tr/td[3]/script")
        puts latlng =  map.text.scan(/GLatLng\S*/)
        lat = nil
        lng = nil
        if latlng[0]
            puts lat = latlng[0].split(",")[0].gsub!("GLatLng(","")
            puts lng = latlng[0].split(",")[1].gsub!(");","")
        end

        basic_info = page2.xpath("/html/body/table[4]/tr/td/table/tr/td/table[3]/tr/td[3]/div[2]/table/tr[3]/td")
        basics = ""
        basic_info.css('td').each do |dt|
            basics = strip_or_self!(dt.text)
        end

        card_payment =false
        payment_types = []
        basic_info.css('img').each { |i| payment_types << i['alt'] }
        puts payment_types
        if payment_types.length == 1 && payment_types.include?("Cash")
            card_payment =false
        else
            card_payment = true
        end
        if payment_types.length >= 2
            card_payment = true
        end

        cuisine = basics.scan(/Cuisine:(?!.*halal).*Price/)[0].gsub!("Cuisine:","").gsub!("Price","")
        puts cuisine = cuisine.scan(/\w/).join("")

        price = basics.scan(/Price:(?!.*halal).*Payment/)[0].gsub!("Price:","").gsub!("Payment","")
        price_length  = price.scan('$').join('').length
        if price_length == 4
            price = 0
        elsif price_length == 5
            price = 1
        elsif price_length == 6
            price = 2
        elsif price_length == 7
            price = 3
        end     
        puts price 

        phone = basics.scan(/Phone:(?!.*halal).*Website/)[0].gsub!("Phone:","").gsub!("Website","")
        puts phone

        hours = basics.scan(/Hours:(?!.*halal)[^\r\t]*.*Phone/)[0].gsub!("Hours:","").gsub!("Phone","")
        hours = strip_or_self!(hours)
        puts hours

        halal_status = " "
        halal_summary = page2.xpath("/html/body/table[4]/tr/td/table/tr/td/table[3]/tr/td[3]/div[3]/div/div").text
        if halal_summary == "Halal summary"
            halal_status = page2.xpath("/html/body/table[4]/tr/td/table/tr/td/table[3]/tr/td[3]/div[4]/table/tr[3]/td/table/tr/td").text
        else
            halal_status = "Not available"
        end
        puts halal_status
        quick_facts = []
        quick_facts_header = page2.xpath("/html/body/table[4]/tr/td/table/tr/td/table[3]/tr/td[5]/div[2]/div/div").text
        if quick_facts_header == "Quick facts"
            quick_facts_path = page2.xpath("/html/body/table[4]/tr/td/table/tr/td/table[3]/tr/td[5]/div[2]/div[2]/table/tr[2]/td/table")
            quick_facts_path.css('b').each do |facts|
                quick_facts << facts.text
            end
        else
            quick_facts = "Not present"
        end
        puts quick_facts

        new_agent = Mechanize.new
        new_agent.open_timeout   = 50
        new_agent.read_timeout   = 50
        mech_page = new_agent.get "#{r_url}"
        path = mech_page.search("//html/body/table[4]/tr/td/table/tr/td/table[3]/tr/td[3]/div[2]/table/tr[3]/td")

        lnk = []
        begin
            path.search('a').each do |node|
                # puts node.attr('href')
                Mechanize::Page::Link.new(node,new_agent,mech_page).click
                lnk << new_agent.page.uri
            end
        rescue
        end

        website = "No website available"
        web_link = lnk[0].to_s
        if web_link.length != 0 && web_link.scan(/facebook/)[0] != "facebook" && web_link.scan(/zabihah/)[0] != "zabihah"
            puts website = web_link
        else
            puts website = "No website available"
        end
        puts "\n\n"

        filters =  []
        if cuisine == "Lebanese"
            filters << 1
        end
        if cuisine == "Meze"
            filters << 2
        end
        if cuisine == "Turkish"
            filters << 3
        end
        if cuisine == "Maroccan"
            filters << 4
        end
        if cuisine == "Italian"
            filters << 5
        end
        if cuisine == "Vietnamese"
            filters << 6
        end
        if cuisine == "Thai"
            filters << 20
        end
        if cuisine == "Indian"
            filters << 21
        end
        if quick_facts.include?("Alcohol-free")
            filters << 12
        end
        if quick_facts.include?("Alcohol allowed")
            filters << 10
        end
        if quick_facts.include?("Alcohol served")
            filters << 11
        end
        if quick_facts.include?("Shisha/hookah available")
            filters << 13
        end
        if price == 1
            filters << 14
        end
        if price == 2
            filters << 15
        end
        if price == 3
            filters << 16
        end
        if quick_facts.include?("Free wifi available")
            filters << 17
        end
        if quick_facts.include?("Wheelchair accessible")
            filters << 18
        end
        if card_payment
            filters << 19
        end
        puts filters
        puts "\n\n"
        if Restaurant.where("lower(name) = ? AND postcode = ?",info[0].downcase, zipcode).first.present?
            puts "\n"
            puts "This restaurant already present in your database...............!!!!!!!!!!!!!"
            puts "\n"
        else
            puts "Restaurant not present in database, creating one"
            puts "\n"
            @restaurant =Restaurant.new
            @restaurant.name = info[0]
            @restaurant.address = info[1]
            @restaurant.description = info[2]
            @restaurant.postcode = zipcode
            @restaurant.flag = "zabihah"
            @restaurant.disabled = false
            @restaurant.country = "United States"
            @restaurant.price = price
            @restaurant.phone = phone
            @restaurant.website = website
            @restaurant.halal_status = halal_status
            @restaurant.lat = lat
            @restaurant.lng = lng
            @restaurant.district = district
            @restaurant.city = city
            @restaurant.short_address = short_address
            @restaurant.filter_ids = filters
            @restaurant.save!
            puts "\n"
            puts "!!!!!!!!!!......................SAVED...........................!!!!!!!!!!"
            puts "\n\n"
        end
        puts "Next"
        puts "\n"
    end

    def strip_or_self!(str)
        str.strip! || str
    end
end