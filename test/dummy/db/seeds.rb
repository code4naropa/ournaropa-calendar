puts "Seeding"

random_nums = 100.times.map{ Random.rand(35*60*60*24) } 

#require OurnaropaCalendar::EventHelper

for i in 0..99 do 
  
  start_time = Time.now.beginning_of_month.beginning_of_week + random_nums[i]
  end_time = start_time.end_of_day
  
  
  OurnaropaCalendar::Event.create(:title => "ABCDEF", :start_time => start_time, :end_time => end_time)
end