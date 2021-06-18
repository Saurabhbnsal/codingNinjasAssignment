class AddIsResolvedToDoubt < ActiveRecord::Migration[6.1]
  def change
    add_column :doubts, :isResolved, :boolean
  end
end
