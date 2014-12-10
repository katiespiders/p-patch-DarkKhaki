class EmailJob
  @queue = :email

  def self.perform(address)
    BeeMailer.new_article(address).deliver
  end
end
