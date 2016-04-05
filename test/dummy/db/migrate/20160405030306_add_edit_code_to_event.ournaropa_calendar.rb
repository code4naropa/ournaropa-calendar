# This migration comes from ournaropa_calendar (originally 20160405030159)
class AddEditCodeToEvent < ActiveRecord::Migration
  def change
    add_column :ournaropa_calendar_events, :edit_code, :string
  end
end
