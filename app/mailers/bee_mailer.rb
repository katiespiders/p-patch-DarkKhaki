class BeeMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_article
    @article = Article.last
    mail(to: "cathode.use@gmail.com", subject: "BEES BUZZ BUZZ BUZZ")
  end
end
