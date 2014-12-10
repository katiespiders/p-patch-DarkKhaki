class BeeMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_article(address)
    @article = Article.last
    mail(to: address, subject: "BEEZ Newz: New Article: #{@article.title}")
    puts """
    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    INSIDE NEW_ARTICLE
    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    """
  end
end
