class AddUserIdToDoubt < ActiveRecord::Migration[6.1]
  def change
    add_column :doubts, :user_id, :number
  end
end
