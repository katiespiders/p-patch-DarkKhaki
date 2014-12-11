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

  describe '#confirm_return' do
    it "sets item's user_id to nil, due to nil and pending to false" do
      user.update(admin: true)
      item.update(user_id: user.id, pending: true)
      patch :confirm_return, { shared_item: {id: item.id, user_id: nil, pending: false, due: nil} }
      expect(item.reload.pending).to be false
      expect(item.reload.user_id).to be nil
      expect(item.reload.due).to be nil
    end
  end

end
