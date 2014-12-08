class User < ActiveRecord::Base
  has_secure_password
  has_many :articles
  has_many :comments, through: :articles
  has_many :shared_items
  has_many :events

  validates :username, presence: true, uniqueness: { message: " is already taken" }
  validates :email, presence: true, confirmation: { message: " doesn't match Email"}, uniqueness: { message: " is already registered; <a href='/sessions/new'>sign in here</a>" }
#  validates :password, format: { with: /\A.*(?=.{8,})(?=.*\d).*\z/, message: " must be at least 8 characters and contain at least 1 digit" }

  def self.spam(task)
    self.all.each { |user| Resque.enqueue(EmailJob, user.email) }
  end

  def profile_link
    "<a href='/users/#{id}'>#{username}</a>".html_safe
  end
end
