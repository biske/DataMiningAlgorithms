require_relative '../apriori.rb'

describe Apriori do
  describe "#frequent" do
    it "should return frequent itemsets" do
      transactions = [["Beef", "Chicken", "Milk"],
                    ["Beef", "Cheese"],
                    ["Cheese", "Boots"],
                    ["Beef", "Chicken", "Cheese"],
                    ["Beef", "Chicken", "Clothes", "Cheese", "Milk"],
                    ["Chicken", "Clothes", "Milk"],
                    ["Chicken", "Milk", "Clothes"]]
      minsup = 0.3                    
      apriori = Apriori.new transactions, minsup
      apriori.frequent.should eq()
    end
  end
end
