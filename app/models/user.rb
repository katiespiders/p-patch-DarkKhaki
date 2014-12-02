class User < ActiveRecord::Base
  has_secure_password
  has_many :articles
  has_many :comments, through: :articles
  has_many :shared_items
  has_many :events
end
