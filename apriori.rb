require 'pp'

require_relative 'item_set'
class Apriori
  def initialize(transactions, minsup)
    @transactions = transactions
    @minsup = minsup
    @c = Array.new
    @f = Array.new
  end

  # Calculate count of itemset
  def count(array)
    c = 0
    @transactions.each do |t|
      if (array - t).empty?
      c += 1
      end
    end
    c
  end

  # Calculate support of itemset
  def support(count)
    count.to_f/@transactions.size.to_f
  end

  # Apriori algorithm for generating frequent itemsets.
  def frequent
    @c[0] = Hash.new
    #itemset = Hash.new
    @transactions.flatten.uniq.sort.each do |t|
      @c[0].store([t], 0)
    end
    @f[0] = Hash.new
    @c[0].each do |key, value|
      c = count(key)
      sup = support(c)
      if sup >= @minsup
      @f[0].store(key, c)
      end
    end
    k = 1
    while !(@f[k-1].empty?)
      puts k
      @c[k] = Hash.new
      @c[k] = candidate_gen(@f[k-1])
      @f[k] = Hash.new
      @c[k].each do |key, value|
        c = count(key)
        sup = support(c)
        if sup >= @minsup
          @f[k].store(key, c)
        end
      end
      k += 1
    end
    puts "@c:"
    pp @c
    puts "------------------------------------"
    puts "@f:"
    pp @f
    puts
    @f
  end

  # Generates frequent itemsets
  def candidate_gen(frequent)
    @c[frequent.size + 1] = Hash.new
    frequent.each_key do |f1|
      frequent.each_key do |f2|
        if (f1[0..-2].eql? f2[0..-2]) && (f1.last < f2.last)
          @c[frequent.size + 1].store((f1 | f2).sort, 0)
        end
      end
    end
    @c[frequent.size + 1]
  end
end

apriori = Apriori.new([
  ["Beef", "Chicken", "Milk"],
  ["Beef", "Cheese"],
  ["Cheese", "Boots"],
  ["Beef", "Chicken", "Cheese"],
  ["Beef", "Chicken", "Clothes", "Cheese", "Milk"],
  ["Chicken", "Clothes", "Milk"],
  ["Chicken", "Milk", "Clothes"]
], 0.3)
apriori.frequent