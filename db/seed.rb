puts "Seeding"

include EventHelper

for i in 0..100 do 
  
  start_time = Time.now.get_beginning_of_month.get_beginning_of_week + i * seconds_per_day
  end_time = start_time.end_of_day
  
  puts start_time
  
 Event.create_and_save(:title => "ABCDEF", :start_time => start_time, :end_time => end_time)
end