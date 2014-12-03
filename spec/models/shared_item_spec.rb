require 'rails_helper'
describe SharedItem do
  describe '#self.create_many' do
    
    it "creates SharedItem db entries with the given quantity and name" do
      SharedItem.create_many('hats',3)
      expect(SharedItem.all.count).to eq(3)
    end

    it "does not create items when they are not valid" do
      SharedItem.create_many('',3)
      expect(SharedItem.all.count).to eq 0
    end

    it "returns a SharedItem object with errors" do
      item = SharedItem.create_many('',2)
      expect(item).to be_instance_of SharedItem
      expect(item.errors.any?).to eq(true)
    end

  end

end
