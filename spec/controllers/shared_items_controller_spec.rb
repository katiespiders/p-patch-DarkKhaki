require 'rails_helper'

describe SharedItemsController, :type => :controller do

  let(:user) {User.create(username: "meow",
                          password: "meow9999",
                          password_confirmation: "meow9999",
                          email: "meow@meow.com") }
  let(:item) { item = SharedItem.create(name: "fish") }
  before { session[:current_user] = user.id }

  describe "#checkout" do
    it "adds an item with the name in params to user's shared_items" do
      item
      post :checkout, {name: "fish"}
      expect(user.shared_items).to include item
    end
  end

  describe '#set_pending' do
    it "sets the item's pending status to true" do
      item.update(user_id: user.id)
      patch :set_pending, { name: "fish" }
      expect(item.reload.pending).to be true
    end
  end

end
