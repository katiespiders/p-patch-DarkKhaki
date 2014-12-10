class EmailJob
  @queue = :email

  def self.perform(address)
    BeeMailer.new_article(address).deliver
    puts """
    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    INSIDE EMAIL JOB PERFORM
    &&&&&&&&&&&&&&&&&&&&&&&&&&&&
    """
  end
end
