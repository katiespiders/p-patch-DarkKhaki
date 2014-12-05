class BeeMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_article(address)
    @article = Article.last
    mail(to: address, subject: "New BEEZ! #{@article.title}")
  end
end
