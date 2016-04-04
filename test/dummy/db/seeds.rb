puts "Seeding"

random_nums = 100.times.map{ Random.rand(35*60*60*24) } 

#require OurnaropaCalendar::EventHelper

for i in 0..99 do 
  
  start_time = (Time.zone.now.beginning_of_month.beginning_of_week + random_nums[i]).to_s
  end_time = ((Time.zone.now.beginning_of_month.beginning_of_week + random_nums[i]).end_of_day).to_s
  location = "somewhere!"
  
  OurnaropaCalendar::Event.create(:title => "ABCDEF", :start_time_text => start_time, :end_time_text => end_time, :location => location)
  
end