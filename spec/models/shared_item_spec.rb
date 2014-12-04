require 'rails_helper'
describe SharedItem do
  describe '#self.create_many' do

    context "non-zero quantity and a name" do
      it "creates SharedItem db entries with the given quantity and name" do
        SharedItem.create_many('hats',3)
        expect(SharedItem.all.count).to eq(3)
      end
    end

    context "no name given" do
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

    context "given a quantity equal or less than 0" do
      it "returns a SharedItem object with erros" do
        item = SharedItem.create_many('hats', 0)
        expect(item).to be_instance_of SharedItem
        expect(item.errors.any?).to eq(true)
      end
    end

  describe '#self.available_item_hash' do
    before {
      SharedItem.create_many('bananas', 10)
      SharedItem.create_many('bees', 5)
      SharedItem.create_many('gloves', 1)
      SharedItem.create_many('sunglasses', 3)
    }
    it "returns a hash with no repeated keys" do
      expect(SharedItem.available_item_hash.keys.count).to eq 4
    end

    it "does not count items which are checked out" do
      item = SharedItem.find_by(name: 'gloves')
      item.update(user_id: 1)
      expect(SharedItem.available_item_hash['gloves']).to be_nil
    end
  end


  end

end
