# @author Brennick Langston
# @version 1.0.0

class SideDish

  attr_accessor :name, :price

  def initialize(name = 0.0, price = 0.0)
    @name = name
    @price = price
  end

  def to_s
    format("%s\s(\$%2.2f)", @name, @price)
  end

end
