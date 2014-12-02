class CreateSharedItems < ActiveRecord::Migration
  def change
    create_table :shared_items do |t|
      t.string :name
      t.integer :user_id
      t.datetime :due

      t.timestamps
    end
  end
end
