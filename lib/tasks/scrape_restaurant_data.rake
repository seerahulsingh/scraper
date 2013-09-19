namespace :scrape do
  desc "Fill database with zabihah restaurant data"

  task zabihah: :environment do
    require 'mechanize'
    require 'nokogiri'
    require 'open-uri'
    
    # page2 = Nokogiri::HTML(open('http://www.zabihah.com/d/Phoenix+31698+Indian-Paradise-II/'))
    agent = Mechanize.new
    page = agent.get("http://www.zabihah.com/b/United-States+125")

    page.links_with(:href => /^\/b\d*/).each do |b_link|
        b_link.click
        c_page = agent.page
        puts b_link.href
        puts "\n\n"

        c_page.links_with(:href => /^\/c\d*/).each do |c_link|
            c_link.click
            d_page = agent.page
            puts c_link.href
            puts "\n\n"

            lnk = []
            d_page.links_with(:href => /^http:\/\/www.zabihah.com\/d\d*/).each { |l| lnk << l.href }
            lnk.uniq! 
            lnk2 = lnk[0...lnk.length-11]
            
            lnk2.each do |d_link|

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

                desc = page2.xpath("//html/body/table[4]/tr[1]/td[1]/table[1]/tr[1]/td[1]/font[1]/preceding-sibling::text()").to_s
                description = strip_or_self!(desc)
                puts info << name << address << description

                info.each { |str| str.encode!('UTF-16', 'UTF-8', :invalid => :replace)  }

                @restaurant =Restaurant.new
                @restaurant.name = info[0]
                @restaurant.address = info[1]
                @restaurant.description = info[2]
                @restaurant.save!
                puts "\n\n"
                puts "!!!!!!!!!!.....................SAVED..............................!!!!!!!!!!"
                puts "\n\n"
            end

            puts "\n\n"
        end

        c_page.links_with(:href => /^\/b\d*/).each do |b2_link|
            b2_link.click
            c2_page = agent.page
            puts b2_link.href
            puts "\n\n"

            c2_page.links_with(:href => /^\/c\d*/).each do |c2_link|
                c2_link.click
                d2_page = agent.page
                puts c2_link.href
                puts "\n\n"

                lnk = []
                d2_page.links_with(:href => /^http:\/\/www.zabihah.com\/d\d*/).each { |l| lnk << l.href }
                lnk.uniq! 
                lnk2 = lnk[0...lnk.length-11]
            
                lnk2.each do |d2_link|
                
                    puts d2_link
                    puts "\n"

                    d2_page.link_with(:href=>"#{d2_link}").click

                    
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

                    desc = page2.xpath("//html/body/table[4]/tr[1]/td[1]/table[1]/tr[1]/td[1]/font[1]/preceding-sibling::text()").to_s
                    description = strip_or_self!(desc)
                    puts info << name << address << description

                    info.each { |str| str.encode!('UTF-16', 'UTF-8', :invalid => :replace)  }

                    @restaurant =Restaurant.new
                    @restaurant.name = info[0]
                    @restaurant.address = info[1]
                    @restaurant.description = info[2]
                    @restaurant.save!
                    puts "\n\n"
                    puts "!!!!!!!!!!......................SAVED...........................!!!!!!!!!!"
                    puts "\n\n"
                end

                puts "\n\n"
            end
        end
    end

    # puts page.parser.xpath("/html/body/table[4]/tr/td/table/tr/td/table[2]/tr/td/table/tr[2]/td/div/table/tr/td/div/a")
    # dump_logger = Logger.new("dump.log")
    # dump_logger.info description
    # cuisine = page.xpath("/html/body/table[4]/tr/td/table/tr/td/table[3]/tr/td[3]/div[2]/table/tr[3]/td/b/following-sibling::text()").to_s
    # puts cuisine

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

  end

    def strip_or_self!(str)
        str.strip! || str
    end
end