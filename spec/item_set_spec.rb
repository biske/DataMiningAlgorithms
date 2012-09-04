require_relative '../item_set'

describe ItemSet do
  it "count should return support count of this itemset in transactions" do
    transactions = [["Chicken", "Clothes", "Milk"],
                    ["Beef", "Chicken", "Milk"],
                    ["Beef", "Cheese"],
                    ["Cheese", "Boots"],
                    ["Beef", "Chicken", "Cheese"],
                    ["Beef", "Chicken", "Clothes", "Cheese", "Milk"],
                    ["Chicken", "Clothes", "Milk"],
                    ["Chicken", "Milk", "Clothes"]]
    array = ["Beef"]
    is = ItemSet.new(array, transactions, 0)
    is.count.should eq(4)
  end
end