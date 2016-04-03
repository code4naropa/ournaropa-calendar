module OurnaropaCalendar

  class MyValidator < ActiveModel::Validator
    def validate(record)      
      
      # try to parse start time
      if record.start_time_text.present?
        if (Chronic.parse(record.start_time_text)).nil?
          record.errors[:start_time_text] << ' was not understood. Sorry!'
          return
        end
      end
      
      # try to parse end time
      if record.end_time_text.present?
        if (Chronic.parse(record.end_time_text)).nil?
          record.errors[:end_time_text] << ' was not understood. Sorry!'
          return
        end
      end
      
      record.parse_start_and_end_times
      
      unless record.start_time < record.end_time
        record.errors[:end_time] << 'cannot be prior to starting time'
      end
      
    end
  end
   
  
  class Event < ActiveRecord::Base
    
    attr_accessor :start_time_text, :end_time_text
    
    scope :relevant, ->(time_boundaries) { where("(start_time >= :start_time AND start_time < :end_time) OR (end_time > :start_time AND end_time <= :end_time) OR (start_time <= :start_time AND end_time >= :end_time)", {:start_time => time_boundaries[:start], :end_time => time_boundaries[:end] }).order("start_time") }
    
    validates :title, length: { minimum: 2 }
    
    # DIFFERENT VALIDATION OF TIMES; CHECK AND DIRECTLY TRANSFER TO START TIME
    
    #validates :start_time, presence: true
    #validates :end_time, presence: true
    validates :location, presence: true
    
    include ActiveModel::Validations
    validates_with MyValidator
    
    before_save :parse_start_and_end_times
    
    def parse_start_and_end_times
      self.start_time = DateTime.strptime(Chronic.parse(self.start_time_text).to_s, "%Y-%m-%d %H:%M:%S %z")
    
      self.end_time = DateTime.strptime(Chronic.parse(self.end_time_text).to_s, "%Y-%m-%d %H:%M:%S %z")
    end
    
  end
end
