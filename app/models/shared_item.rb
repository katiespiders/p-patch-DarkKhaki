class SharedItem < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { minimum: 1 }

  def self.create_many(name, quantity)
    # if quantity == 0
    quantity.times do |f|
      item = SharedItem.create(name: name)
      unless item.valid?
        return item
      end
    end
  end

end
