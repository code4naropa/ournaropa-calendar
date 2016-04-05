module OurnaropaCalendar

  
  # validates that event starts before it ends
  class MyValidator < ActiveModel::Validator
    def validate(record)      
            
      if record.errors[:start_time].length == 0 and record.start_time.nil?
        record.errors[:start_time] << 'was not understood. Sorry!'
      end

      if record.errors[:end_time].length == 0 and record.end_time.nil?
        record.errors[:end_time] << 'was not understood. Sorry!'
      end
      
      if record.errors[:start_time].length == 0 and record.errors[:end_time].length == 0      
        if record.start_time > record.end_time
          record.errors[:end_time] << 'cannot be prior to starting time'
        end    
      end
      
    end
  end
   
  
  class Event < ActiveRecord::Base
        
    attr_accessor :start_time_text, :end_time_text
    
    # if loaded from database, define start_time_text and end_time_text
    after_find do |event|
      if self.start_time.present?
        event.start_time_text = self.start_time.strftime("%-m/%-d/%Y %l:%M %p")
      end
      
      if event.end_time.present?
        event.end_time_text = self.end_time.strftime("%-m/%-d/%Y %l:%M %p")
      end
    end
    
    scope :relevant, ->(time_boundaries) { where("(start_time >= :start_time AND start_time < :end_time) OR (end_time > :start_time AND end_time <= :end_time) OR (start_time <= :start_time AND end_time >= :end_time)", {:start_time => time_boundaries[:start], :end_time => time_boundaries[:end] }).order("start_time") }
    
    validates :title, length: { minimum: 2 }
    
    include ActiveModel::Validations
    validates_with MyValidator
    
    validates :location, presence: true
    
    before_validation :parse_start_and_end_times
    
    # before creation: create edit code
    before_create do
      self.edit_code = SecureRandom.hex(5).upcase
    end
    
    # gets the event duration in days
    def duration_in_days
      
      num_days = ((self.end_time.beginning_of_day - self.start_time.beginning_of_day) / 1.day).round
      
      # if event ends at midnight, don't count this as a new day
      if self.ends_at_midnight? and start_time != end_time
        num_days -= 1
      end
        
      return num_days  
      
    end
      
    # does the event end at midnight?
    def ends_at_midnight?
      if self.end_time == self.end_time.beginning_of_day
        return true
      else
        return false
      end
    end
    
      
    private
    
      def parse_start_and_end_times
        
        if self.start_time_text.present?
          self.start_time = Chronic.parse(self.start_time_text)
        else
          self.errors[:start_time] << 'can\'t be blank'
        end  
  
        if self.end_time_text.present?
          self.end_time = Chronic.parse(self.end_time_text)
        else
          self.errors[:end_time] << 'can\'t be blank'
        end
        
      end
    
    
      def is_relevant? time_start, time_end
        if (self.start_time >= time_start and self.start_time < time_end) || (self.end_time > time_start and self.end_time <= time_end) || (self.start_time <= time_start and self.end_time >= time_end)
          return true
        else
          return false
        end
      end
    
  end
end
