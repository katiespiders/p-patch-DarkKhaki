class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  validates :content, presence: true

  def commenter
    User.find(user_id)
  end

  def comment_path
    " posted at <a href='/comments/#{id}'>#{timestamp}</a>".html_safe
  end

  def timestamp
    created_at.strftime('%l:%M %P on %a %-d %b %Y')
  end

  def byline
    (commenter.profile_link + comment_path).html_safe
  end
end
