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
    @c[0] = Array.new
    
    @transactions.flatten.uniq.sort.each do |t|
      @c[0].push([t])
    end
    @f[0] = Hash.new
    @c[0].each do |elem|
      c = count(elem)
      sup = support(c)
      if sup >= @minsup
      @f[0].store(elem, c)
      end
    end
    k = 1
    while !(@f[k-1].empty?)
      @c[k] = Array.new
      @c[k] = candidate_gen(@f[k-1], k)
      @f[k] = Hash.new
      @c[k].each do |elem|
        c = count(elem)
        sup = support(c)
        if sup >= @minsup
          @f[k].store(elem, c)
        end
      end
      k += 1
    end
    @c.pop
    @f.pop
    @f
  end

  # Generates candidate itemsets from frequent itemsets found in previous step
  def candidate_gen(frequent, k)
    @c[k] = Array.new
    frequent.each_key do |f1|
      frequent.each_key do |f2|
        if (f1[0..-2].eql? f2[0..-2]) && (f1.last < f2.last)
          candidate = (f1 | f2).sort
          @c[k].push(candidate)
          if !(candidate.combination(k).to_a - frequent.keys).empty?
            @c[k].delete(candidate)
          end
        end
      end
    end
    @c[k]
  end
end