class ItemSet
  def initialize(array, count = 0)
    @array = Array.new
    @array.push(array)
    @count = count
  end
  
  attr_accessor :array
  
  def count(transaction)
    transaction.each do |t|
      if (@array - t).empty?
        @count += 1
      end
    end
    return @count
  end
  
  
  def support(transaction)
    count(transaction).to_f/transaction.size.to_f
  end
end