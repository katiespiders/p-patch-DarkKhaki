class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start
      t.datetime :end
      t.text :description
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
