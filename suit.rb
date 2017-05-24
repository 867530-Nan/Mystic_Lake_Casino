# @author Brennick Langston
# @version 1.0.0

class Suit

  attr_accessor :type, :value

  def initialize(type = nil, value = nil)
    @type = type
    @value = value
  end

  def ==(other)
    @value == other.value
  end

  def >(other)
    @value > other.value
  end

  def <(other)
    @value < other.value
  end

  def <=>(other)
    @value <=> other.value
  end
end
