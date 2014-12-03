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

end
