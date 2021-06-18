class CreateDoubtComments < ActiveRecord::Migration[6.1]
  def change
    create_table :doubt_comments do |t|
      t.string :body
      t.integer :user_id
      t.integer :doubt_id

      t.timestamps
    end
  end
end
