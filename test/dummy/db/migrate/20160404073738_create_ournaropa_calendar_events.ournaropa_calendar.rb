# This migration comes from ournaropa_calendar (originally 20160402155304)
class CreateOurnaropaCalendarEvents < ActiveRecord::Migration
  def change
    
    enable_extension 'uuid-ossp'
    
    create_table :ournaropa_calendar_events, id: :uuid do |t|
      t.string :title
      t.text :description
      t.datetime :start_time, :index => true
      t.datetime :end_time, :index => true
      t.string :location
      t.string :organizer_name
      t.string :organizer_email

      t.timestamps null: false
    end
  end
end
