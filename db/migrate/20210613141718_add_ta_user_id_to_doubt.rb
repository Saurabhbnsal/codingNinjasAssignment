class AddTaUserIdToDoubt < ActiveRecord::Migration[6.1]
  def change
    add_column :doubts, :ta_user_id, :integer
  end
end
