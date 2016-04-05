class AddEditCodeToEvent < ActiveRecord::Migration
  def change
    add_column :ournaropa_calendar_events, :edit_code, :string
  end
end
