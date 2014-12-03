class SharedItem < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true

  def self.create_many(name, quantity)
    quantity.times do |f|
      unless SharedItem.create(name: name)
        return false
      end
    end
  end

end
