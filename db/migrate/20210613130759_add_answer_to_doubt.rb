class AddAnswerToDoubt < ActiveRecord::Migration[6.1]
  def change
    add_column :doubts, :answer, :string
  end
end
