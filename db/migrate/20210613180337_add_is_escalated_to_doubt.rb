class AddIsEscalatedToDoubt < ActiveRecord::Migration[6.1]
  def change
    add_column :doubts, :is_escalated, :boolean
  end
end
