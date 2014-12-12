class AddSharedItemPending < ActiveRecord::Migration
  def change
    add_column :shared_items, :pending, :boolean
  end
end
