require 'pp'

class Apriori
  def frequent(a)
    res = []
    a.each do |a1|
      a.each do |a2|
        if (a1[0..-2].eql? a2[0..-2]) && !(a1.last.eql? a2.last)
          pp a1
          pp a2
          fk = (a1 + a2).uniq.sort
          puts
        res << fk
        end
      end
    end
    res.uniq
  end
end

a = [["Beef"], ["Cheese"], ["Chicken"], ["Clothes"], ["Milk"]]
apriori = Apriori.new
res = apriori.frequent(a)
pp res
