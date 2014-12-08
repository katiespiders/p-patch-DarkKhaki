class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true

  def byline
    "by #{User.find(user_id).username} #{created_at.strftime(" on %a, %-d %B, %Y")}"
  end
end
