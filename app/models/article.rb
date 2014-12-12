class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true

  def author
    User.find(user_id)
  end

  def byline
    "by #{author.profile_link} #{created_at.strftime(" on %a, %-d %B, %Y")}".html_safe
  end

  def comments_string
    count = comments.count
    "#{count} #{count == 1 ? " comment" : " comments"}"
  end
end
