class User < ActiveRecord::Base
  has_secure_password
  has_many :articles
  has_many :comments, through: :articles
  has_many :shared_items
  has_many :events

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, confirmation: true, uniqueness: true
  validates :email_confirmation, presence: true
#  validates :password, length: { minimum: 8 }

end
