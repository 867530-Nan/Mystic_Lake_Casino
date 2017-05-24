# @author Brennick Langston
# @version 1.0.0

class Entree

  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def to_s
    "#{@name}\s(\$#{@price})"
  end
end
