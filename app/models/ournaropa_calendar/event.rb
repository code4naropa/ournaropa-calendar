module OurnaropaCalendar

  class MyValidator < ActiveModel::Validator
    def validate(record)
      unless record.start_time < record.end_time
        record.errors[:end_time] << 'cannot be prior to starting time'
      end
    end
  end
   
  
  class Event < ActiveRecord::Base
    
    attr_accessor :start_time_text, :end_time_text
    
    scope :relevant, ->(time_boundaries) { where("(start_time >= :start_time AND start_time < :end_time) OR (end_time > :start_time AND end_time <= :end_time) OR (start_time <= :start_time AND end_time >= :end_time)", {:start_time => time_boundaries[:start], :end_time => time_boundaries[:end] }).order("start_time") }
    
    validates :title, length: { minimum: 2 }
    
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :location, presence: true
    
    include ActiveModel::Validations
    validates_with MyValidator, if: "start_time.present? and end_time.present?"
    
  end
end
