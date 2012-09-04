class ItemSet
  def initialize(array, transactions, count = 0)
    @array = array
    @transactions = transactions
    @count = count
  end
  
  attr_accessor :array
  
  def count
    @count = 0
    @transactions.each do |t|
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