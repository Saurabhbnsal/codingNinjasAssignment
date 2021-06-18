class CreateDoubts < ActiveRecord::Migration[6.1]
  def change
    create_table :doubts do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
