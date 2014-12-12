class SharedItem < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { minimum: 1 }

  def self.create_many(name, quantity)
    if quantity <= 0
      item = SharedItem.create(name: name, pending: false)
      item.errors.messages[:quantity] = ["must be greater than 0"]
      return item
    end
    quantity.times do |f|
      item = SharedItem.create(name: name, pending: false)
      unless item.valid?
        return item
      end
    end
  end

  def self.overdue_items
    SharedItem.where("due < ? and user_id IS NOT NULL", Date.today)
  end

  def self.available_item_hash
    item_hash = {}
    SharedItem.all.each do |item|
      if item.user_id == nil
        add_to_hash(item_hash, item.name)
      end
    end
    item_hash
  end

  def self.users_items_array(user, pending_items)
    split_hash(users_items_hash(user, pending_items))
  end


  private

  def self.users_items_hash(user, pending_items)
    users_items = {}
    user.shared_items.each do |item|
      if item.pending == pending_items
        unique_key = item.name+"**_**"+item.due.to_date.to_s
        add_to_hash(users_items, unique_key)
      end
    end
    users_items
  end

  def self.split_hash(hash)
    hash.collect do |k, v|
      name, date = k.split('**_**')
      quantity = v
      [name, date, quantity]
    end
  end

  def self.add_to_hash(hash, item)
    if hash[item]
      hash[item] += 1
    else
      hash[item] = 1
    end
  end



end
