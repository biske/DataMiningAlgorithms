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
    #pp @c[0]
    #pp @f[0]
    k = 0
    while @f[k].any?
      k += 1
      @c[k] = []
      @c[k] = candidate_gen(@f[k-1])
      pp @c[k]
      @c[k].each do |itemset|
        itemset.count(@transactions)
      end
      @f[k] = @c[k].select do |value|
        value.support(@transactions) >= @minsup
      end
    end
    @f
  end

  # Generates frequent itemsets
  def candidate_gen(frequent)
    @c[frequent.size + 1] = []
    frequent.each do |f1|
      frequent.each do |f2|
        if (f1.array[0..-2].eql? f2.array[0..-2]) && (f1.array.last < f2.array.last)
          @c[frequent.size + 1] << ItemSet.new((f1.array + [f2.array.last]).uniq.sort, 0)
        end
      end
    end
    #pp @c[frequent.size + 1]
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