namespace :scrape do
  desc "Fill database with zabihah restaurant data"

  task zabihah: :environment do
    require 'mechanize'
    require 'nokogiri'
    require 'open-uri'
    
    page = Nokogiri::HTML(open('http://www.zabihah.com/d/Brooklyn+16996+Halal-Kitchen-II/'))

    
    name = page.css('.titleBM')[0].text

    addr = page.css('.titleBM')[0].parent.text
    address = addr.gsub!(/#{name}/,"")
    
    description = page.xpath("//html/body/table[4]/tr[1]/td[1]/table[1]/tr[1]/td[1]")
    dump_logger = Logger.new("dump.log")
    
    dump_logger.info description
    puts description

    # puts description


    # User.create!(username: "rahulsingh",
    #             name: "Rahul Singh",
    #              email: "rahul692000@gmail.com",
    #              password: "rahul123",
    #              password_confirmation: "rahul123")
    # 7.times do |n|
    #   username = "userxyg_#{n+1}"
    #   name  = Faker::Name.name
    #   email = "example-#{n+1}@railstutorial.org"
    #   password  = "password"
    #   User.create!(username:username, 
    #               name: name,
    #                email: email,
    #                password: password,
    #                password_confirmation: password)
    # end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               

    # users = User.all(limit: 6)
    #   35.times do |n|
    #     category = "category-#{n}"
    #      name = Faker::Name.name
    #      description = Faker::Lorem.sentence(5)
    #   users.each { |user| user.activities.create!(category: category,name: name,description: description) }
    # end
  end
end