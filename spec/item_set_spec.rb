require_relative '../item_set'

describe ItemSet do
  before :all do
    @transactions = [["Beef", "Chicken", "Milk"],
                    ["Beef", "Cheese"],
                    ["Cheese", "Boots"],
                    ["Beef", "Chicken", "Cheese"],
                    ["Beef", "Chicken", "Clothes", "Cheese", "Milk"],
                    ["Chicken", "Clothes", "Milk"],
                    ["Chicken", "Milk", "Clothes"]]
  end
  it "count should return 4 support count for ['Beef']" do
    array = ["Beef"]
    is = ItemSet.new(array, @transactions, 0)
    is.count.should eq(4)
  end
  it "count should return 3 support count for ['Beef', 'Chicken']" do
    array = ["Beef", "Chicken"]
    is = ItemSet.new(array, @transactions, 0)
    is.count.should eq(3)
  end
  it "count should return 3 support count for ['Chicken', 'Clothes', 'Milk']" do
    array = ['Chicken', 'Clothes', 'Milk']
    is = ItemSet.new(array, @transactions, 0)
    is.count.should eq(3)
  end
end