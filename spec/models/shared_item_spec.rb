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


  end

end
