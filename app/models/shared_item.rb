class SharedItem < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { minimum: 1 }

  def self.create_many(name, quantity)
    if quantity <= 0
      item = SharedItem.create(name: name)
      item.errors.messages[:quantity] = ["must be greater than 0"]
      return item
    end
    quantity.times do |f|
      item = SharedItem.create(name: name)
      unless item.valid?
        return item
      end
    end
  end

  def self.available_item_hash
    item_hash = {}
    SharedItem.all.each do |item|
      if item.user_id == nil
        add_to_hash(item_hash, item)
      end
    end
    item_hash
  end

  def self.users_items_hash(user)
    users_items = {}
    user.shared_items.each do |item|
      add_to_hash(users_items, item)
    end
    users_items
  end

  private

  def self.add_to_hash(hash, item)
    if hash[item.name]
      hash[item.name] += 1
    else
      hash[item.name] = 1
    end
  end

end
