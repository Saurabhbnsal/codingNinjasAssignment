class AddTaIdToDoubtDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :doubt_details, :ta_id, :integer
  end
end
