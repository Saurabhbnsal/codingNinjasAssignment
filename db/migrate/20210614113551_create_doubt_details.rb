class CreateDoubtDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :doubt_details do |t|
      t.integer :doubt_id
      t.text :status

      t.timestamps
    end
  end
end
