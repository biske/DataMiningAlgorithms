require_relative '../apriori.rb'

describe Apriori do
  before :all do
    transactions = [["Beef", "Chicken", "Milk"],
                    ["Beef", "Cheese"],
                    ["Cheese", "Boots"],
                    ["Beef", "Chicken", "Cheese"],
                    ["Beef", "Chicken", "Clothes", "Cheese", "Milk"],
                    ["Chicken", "Clothes", "Milk"],
                    ["Chicken", "Milk", "Clothes"]]
    minsup = 0.3                    
    @apriori = Apriori.new transactions, minsup                    
  end
  
  describe "#frequent" do
  end
  
  describe "#candidate-gen" do
    it "given f[1] it should return c[2] itemsets" do
      f1 = {["Beef"]=>4, ["Cheese"]=>4, ["Chicken"]=>5, ["Clothes"]=>3, ["Milk"]=>4}
      c2 = {["Beef", "Cheese"] => 0,["Beef", "Chicken"] => 0, ["Beef", "Clothes"] => 0, ["Beef", "Milk"] => 0,
            ["Cheese", "Chicken"] => 0, ["Cheese", "Clothes"] => 0, ["Cheese", "Milk"] => 0, ["Chicken", "Clothes"] => 0,
            ["Chicken", "Milk"] => 0, ["Clothes", "Milk"] => 0}
      @apriori.candidate_gen(f1).should eq(c2)
    end
  end
end
