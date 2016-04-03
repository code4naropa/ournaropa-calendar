class CreateOurnaropaCalendarEvents < ActiveRecord::Migration
  def change
    create_table :ournaropa_calendar_events do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.string :organizer_name
      t.string :organizer_email

      t.timestamps null: false
    end
  end
end
