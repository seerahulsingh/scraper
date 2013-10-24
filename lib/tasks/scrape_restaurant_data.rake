namespace :scrape do
    desc "Fill database with zabihah restaurant data"

    task zabihah: :environment do
        require 'mechanize'
        require 'nokogiri'
        require 'open-uri'
        
        page2 = Nokogiri::HTML(open('http://www.zabihah.com/d/Tuscaloosa+33303+Sitar-Indian-Cuisine/'))
        # agent = Mechanize.new
        # page = agent.get("http://www.zabihah.com/b/United-States+125")

        # page.links_with(:href => /^\/b\d*/).each do |b_link|
        #     begin
        #         b_link.click
        #         c_page = agent.page
        #         puts b_link.href
        #         puts "\n\n"

        #         c_page.links_with(:href => /^\/c\d*/).each do |c_link|
        #             begin
        #                 c_link.click
        #                 d_page = agent.page
        #                 puts c_link.href
        #                 puts "\n\n"

        #                 lnk = []
        #                 d_page.links_with(:href => /^http:\/\/www.zabihah.com\/d\d*/).each { |l| lnk << l.href }
        #                 lnk.uniq! 
        #                 lnk2 = lnk[0...lnk.length-11]
                        
        #                 lnk2.each do |d_link|
        #                     begin
        #                         puts d_link
        #                         puts "\n"
                                
        #                         d_page.link_with(:href=>"#{d_link}").click

                                
        #                         r_page = agent.page
        #                         r_url = r_page.uri

        #                         page2 = Nokogiri::HTML(open(r_url))


        #                         name = page2.css('.titleBM')[0]
        #                         if name != nil
        #                             name = name.text
        #                             addr = page2.css('.titleBM')[0].parent.text
        #                         elsif page2.css('.sysTitleL')[0] != nil
        #                             name = page2.css('.sysTitleL')[0].text
        #                             addr = page2.css('.sysTitleL')[0].parent.text
        #                         else
                                    
        #                         end
        #                         info = []

        #                         address = addr.gsub!(name,"")
        #                         striped_address = strip_or_self!(address)
        #                         zipcode = striped_address.split(//).last(5).join("").to_s

        #                         desc = page2.xpath("//html/body/table[4]/tr[1]/td[1]/table[1]/tr[1]/td[1]/font[1]/preceding-sibling::text()").to_s
        #                         description = strip_or_self!(desc)
        #                         puts info << name << address << description
        #                         puts "zipcode : #{zipcode}"
        #                         puts "\n"

        #                         info.each { |str| str.encode!('utf-8', :invalid => :replace, :undef => :replace)  }
        #                         zipcode.encode!('utf-8', :invalid => :replace, :undef => :replace)

        #                         if Restaurant.where("lower(name) = ? AND postcode = ?",info[0].downcase, zipcode).first.present?
        #                             puts "\n"
        #                             puts "This restaurant already present in your database...............!!!!!!!!!!!!!"
        #                             puts "\n"
        #                         else
        #                             @restaurant =Restaurant.new
        #                             @restaurant.name = info[0]
        #                             @restaurant.address = info[1]
        #                             @restaurant.description = info[2]
        #                             @restaurant.postcode = zipcode
        #                             @restaurant.flag = "zabihah"
        #                             @restaurant.disabled = false
        #                             @restaurant.save!
        #                             puts "\n"
        #                             puts "!!!!!!!!!!......................SAVED...........................!!!!!!!!!!"
        #                             puts "\n\n"
        #                         end
        #                     rescue
        #                     end
        #                 end

        #                 puts "\n\n"
        #             rescue
        #             end
        #         end

        #         c_page.links_with(:href => /^\/b\d*/).each do |b2_link|
        #             begin
        #                 b2_link.click
        #                 c2_page = agent.page
        #                 puts b2_link.href
        #                 puts "\n\n"

        #                 c2_page.links_with(:href => /^\/c\d*/).each do |c2_link|
        #                     begin
        #                         c2_link.click
        #                         d2_page = agent.page
        #                         puts c2_link.href
        #                         puts "\n\n"

        #                         lnk = []
        #                         d2_page.links_with(:href => /^http:\/\/www.zabihah.com\/d\d*/).each { |l| lnk << l.href }
        #                         lnk.uniq! 
        #                         lnk2 = lnk[0...lnk.length-11]
                            
        #                         lnk2.each do |d2_link|
        #                             begin
        #                                 puts d2_link
        #                                 puts "\n"

        #                                 d2_page.link_with(:href=>"#{d2_link}").click

                                        
        #                                 r_page = agent.page
        #                                 r_url = r_page.uri

        #                                 page2 = Nokogiri::HTML(open(r_url))


        #                                 name = page2.css('.titleBM')[0]
        #                                 if name != nil
        #                                     name = name.text
        #                                     addr = page2.css('.titleBM')[0].parent.text
        #                                 elsif page2.css('.sysTitleL')[0] != nil
        #                                     name = page2.css('.sysTitleL')[0].text
        #                                     addr = page2.css('.sysTitleL')[0].parent.text
        #                                 else
                                            
        #                                 end
        #                                 info = []

        #                                 address = addr.gsub!(name,"")
                                        
        #                                 striped_address = strip_or_self!(address)
        #                                 zipcode = striped_address.split(//).last(5).join("").to_s
                                        
        #                                 desc = page2.xpath("//html/body/table[4]/tr[1]/td[1]/table[1]/tr[1]/td[1]/font[1]/preceding-sibling::text()").to_s
        #                                 description = strip_or_self!(desc)
        #                                 puts info << name << address << description
        #                                 puts "zipcode : #{zipcode}"
                                        
        #                                 info.each { |str| str.encode!('utf-8', :invalid => :replace, :undef => :replace)  }
        #                                 zipcode.encode!('utf-8', :invalid => :replace, :undef => :replace)

        #                                 if Restaurant.where("lower(name) = ? AND postcode = ?",info[0].downcase, zipcode).first.present?
        #                                     puts "\n"
        #                                     puts "This restaurant already present in your database...............!!!!!!!!!!!!!"
        #                                     puts "\n"
        #                                 else
        #                                     @restaurant =Restaurant.new
        #                                     @restaurant.name = info[0]
        #                                     @restaurant.address = info[1]
        #                                     @restaurant.description = info[2]
        #                                     @restaurant.postcode = zipcode
        #                                     @restaurant.flag = "zabihah"
        #                                     @restaurant.disabled = false
        #                                     @restaurant.save!
        #                                     puts "\n"
        #                                     puts "!!!!!!!!!!......................SAVED...........................!!!!!!!!!!"
        #                                     puts "\n\n"
        #                                 end
        #                             rescue
        #                             end
        #                         end

        #                         puts "\n\n"
        #                     rescue
        #                     end
        #                 end
        #             rescue
        #             end
        #         end
        #     rescue
        #     end
        # end

        # puts page.parser.xpath("/html/body/table[4]/tr/td/table/tr/td/table[2]/tr/td/table/tr[2]/td/div/table/tr/td/div/a")
        # dump_logger = Logger.new("dump.log")
        # dump_logger.info description
        
        # cuisine = page2.xpath("/html/body/table[4]/tr/td/table/tr/td/table[3]/tr/td[3]/div[2]/table/tr[3]/td/br[1]/preceding-sibling::text()").to_s
        # cuisine = strip_or_self!(cuisine)
        # # puts cuisine
        map = page2.xpath("/html/body/table[4]/tr/td/table/tr/td/table[4]/tr/td[3]/script")
        puts latlng =  map.text.scan(/GLatLng\S*/)
        puts lat = latlng[0].split(",")[0].gsub!("GLatLng(","")
        puts lng = latlng[0].split(",")[1].gsub!(");","")

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
        puts cuisine

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

        # agent = Mechanize.new
        # page2 = agent.get "http://www.zabihah.com/d/Irving+33674+Bombay-Sizzler-Pub-amp-Grill/"
        # path = page2.search("//html/body/table[4]/tr/td/table/tr/td/table[3]/tr/td[3]/div[2]/table/tr[3]/td")

        new_agent = Mechanize.new
        mech_page = new_agent.get "http://www.zabihah.com/d/Irving+33674+Bombay-Sizzler-Pub-amp-Grill/"
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

        # path.search('b').each do |node|
        #     if node.next
        #         puts strip_or_self!("#{node.next.text}")
        #     end
        # end

        # name = page2.css('.titleBM')[0].text
        # addr = page2.css('.titleBM')[0].parent.text
        # address = addr.gsub!(name,"")
        # desc = page2.xpath("//html/body/table[4]/tr[1]/td[1]/table[1]/tr[1]/td[1]/font[1]/preceding-sibling::text()").to_s
        # description = strip_or_self!(desc)

        # puts name
        # puts address
        # puts description

        # info =[]

        # puts info << name << address << description

        # info.each { |str| str.encode!('utf-8', 'iso-8859-1')  }
        
        # info[0] = info[0].encode('utf-8', 'iso-8859-1')
        # info[1] = info[1].encode('utf-8', 'iso-8859-1')
        # info[2] = info[2].encode('utf-8', 'iso-8859-1')
        
        # info[0] = info[0].encode('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
        # info[1] = info[1].encode('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
        # info[2] = info[2].encode('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')

        # info[0] = info[0].encode('UTF-16', 'UTF-8', :invalid => :replace)
        # info[1] = info[1].encode('UTF-16', 'UTF-8', :invalid => :replace)
        # info[2] = info[2].encode('UTF-16', 'UTF-8', :invalid => :replace)
        
        # @restaurant =Restaurant.new
        # @restaurant.name = info[0]
        # @restaurant.address = info[1]
        # @restaurant.description = info[2]
        # @restaurant.save!
        # puts "\n\n"
        # puts "!!!!!!!!!!......................SAVED...........................!!!!!!!!!!"
        # puts "\n\n"
      #   arrys  = ["facebook",43,".com"]
      #   arry = ["zabihah",2,"eathalal",nil,4,5]
      #   arrys.each do |ay|
      #       begin
      #           puts ay.length
      #           arry.each do |a|
      #               begin
      #                   puts a.length
      #               rescue
      #                   puts "here"
      #               end
      #           end
      #       rescue
      #           puts 'there'
      #       end
      #   end
    end

    task delete: :environment do
        Restaurant.where("flag = ?","zabihah").destroy_all
    end

    def strip_or_self!(str)
        str.strip! || str
    end

end