class AddIsPickedToDoubt < ActiveRecord::Migration[6.1]
  def change
    add_column :doubts, :is_picked, :boolean
  end
end
