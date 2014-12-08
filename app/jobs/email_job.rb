class EmailJob
  @queue = :email

  # is this the best way to do this?
  def self.perform(address, task)
    raise task.inspect
    case task
    when :article then BeeMailer.new_article(address).deliver
    when :reminder then BeeMailer.reminder(address).deliver
    when :overdue then BeeMailer.overdue(address).deliver
    end
  end
end
