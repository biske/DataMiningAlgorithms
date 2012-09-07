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
    it "it should output frequent itemsets" do
      output = [{["Beef"]=>4, ["Cheese"]=>4, ["Chicken"]=>5, ["Clothes"]=>3, ["Milk"]=>4},
                {["Beef", "Cheese"]=>3,
                 ["Beef", "Chicken"]=>3,
                 ["Chicken", "Clothes"]=>3,
                 ["Chicken", "Milk"]=>4,
                 ["Clothes", "Milk"]=>3},
                {["Chicken", "Clothes", "Milk"]=>3}]
      @apriori.frequent.should eq(output)
    end
  end
  
  describe "#candidate-gen" do
    it "given f[1] it should return c[2] itemsets" do
      f1 = {["Beef"]=>4, ["Cheese"]=>4, ["Chicken"]=>5, ["Clothes"]=>3, ["Milk"]=>4}
      c2 = [["Beef", "Cheese"], ["Beef", "Chicken"], ["Beef", "Clothes"], ["Beef", "Milk"],
            ["Cheese", "Chicken"], ["Cheese", "Clothes"], ["Cheese", "Milk"], ["Chicken", "Clothes"],
            ["Chicken", "Milk"], ["Clothes", "Milk"]]
      @apriori.candidate_gen(f1, 1).should eq(c2)
    end
    it "given f[2] it should return c[2] itemsets" do
      f2 = {["Beef", "Cheese"] => 3,["Beef", "Chicken"] => 3, ["Chicken", "Clothes"] => 3, ["Chicken", "Milk"] => 4, ["Clothes", "Milk"] => 3}
      c3 = [["Chicken", "Clothes", "Milk"]]
      @apriori.candidate_gen(f2, 2).should eq(c3)
    end
  end
end
