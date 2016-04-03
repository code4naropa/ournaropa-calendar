module OurnaropaCalendar
  module EventsHelper
    
    require "time"
    
    def days_of_the_week
      return ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    end
    
    def seconds_per_day
      return 24*60*60;
    end
    
    def get_calendar_start_date time
      return time.beginning_of_month.beginning_of_week
    end
    
    def get_calendar_end_date time
      return time.end_of_month.end_of_week
    end
    
    def get_days_in_calendar time
      puts ((get_calendar_end_date(time) - get_calendar_start_date(time)) / seconds_per_day).round
      return ((get_calendar_end_date(time) - get_calendar_start_date(time)) / seconds_per_day).round
    end

    # checks if two dates are in the same year
    def is_same_year? date1, date2
      return date1.beginning_of_year == date2.beginning_of_year
    end
    
    # checks if two dates are in the same month
    def is_same_month? date1, date2
      return date1.beginning_of_month == date2.beginning_of_month
    end
    
    # checks if two dates are on the same day
    def is_same_day? date1, date2
      return date1.beginning_of_day == date2.beginning_of_day
    end

    # formatting of start and end time
    def format_start_and_end_date start_time, end_time
      if is_same_day?(start_time, end_time)
        return start_time.strftime("%a, %b %e, %Y")
      elsif is_same_year?(start_time, end_time)
        return start_time.strftime("%a, %b %e") + " - " + end_time.strftime("%a, %b %e, %Y")
      else
        return start_time.strftime("%a, %b %e, %Y") + " - " + end_time.strftime("%a, %b %e, %Y")
      end
    end        
    
    # formatting of start and end time
    def format_start_and_end_time start_time, end_time
      return start_time.strftime("%l:%M %P") + " - " + end_time.strftime("%l:%M %P")
    end    
    
    # formatting of start and end time
    def format_start_and_end_time_bk start_time, end_time
      if is_same_day?(start_time, end_time)
        return start_time.strftime("%a, %b %e, %Y, %l:%M %P") + " - " + end_time.strftime("%l:%M %P")
      else
        return start_time.strftime("%a, %b %e, %Y, %l:%M %P") + " - " + end_time.strftime("%a, %b %e, %Y, %l:%M %P")
      end
    end
    
    # formats an event time to show on calendar main view
    def format_time current_day, start_time, end_time
      
      # multi-day event?
      if start_time < current_day.beginning_of_day
        return ""
      end
      
      # start with hour
      formatted_string = start_time.strftime("%l")
      
      # add minutes if non-zero
      formatted_string += start_time.strftime("%M") == "00" ? "" : ":" + start_time.strftime("%M")
      
      # add PM if not am
      formatted_string += start_time.strftime("%P") == "am" ? "" : "p"
      
      return formatted_string
    end
    
  end
end
