require 'pp'
require_relative 'item_set'

class Apriori
  def initialize(transactions, minsup)
    @transactions = transactions
    @minsup = minsup
    @c = Array.new
    @f = Array.new
  end

  # Apriori algorithm for generating frequent itemsets.
  def frequent
    @c[0] = Array.new
    @transactions.flatten.uniq.sort.each do |t|
      @c[0] << ItemSet.new(t, 0)
    end
    @f[0] = @c[0].select do |value| 
      value.support(@transactions) >= @minsup
    end
    # pp @c
    # puts '--------------------------------------'
    # pp @f
    k = 0
    begin
      k += 1
      @c[k] = []
      @c[k] = candidate_gen(@f[k-1])
      #pp @c[k]
      @transactions.each do |t|
        @c[k].each do |itemset|
          itemset.support(@transactions)
        end
      end
      @f[k] = @c[k].select do |value|
        value.support(@transactions) >= @minsup
      end
    end while @f[k].nil?
    pp @f
  end

  # Generates frequent itemsets
  def candidate_gen(frequent)
    #pp frequent
    @c[frequent.size + 1] = []
    frequent.each do |itemset1|
      frequent.each do |itemset2|
        if (itemset1.array - [itemset1.array.last]).eql?(itemset2.array - [itemset2.array.last]) && itemset1.array.last < itemset2.array.last
          @c[frequent.size + 1].push(ItemSet.new(itemset1.array.push(itemset2.array.last)))
        end
      end
    end
  end
end

apriori = Apriori.new([
  ["Beef", "Chicken", "Milk"],
  ["Beef", "Cheese"],
  ["Cheese", "Boots"],
  ["Beef", "Chicken", "Clothes", "Cheese", "Milk"],
  ["Chicken", "Clothes", "Milk"],
  ["Chicken", "Milk", "Clothes"]
], 0.3)
apriori.frequent
