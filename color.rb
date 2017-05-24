# @author Brennick Langston
# @version 1.0.0

class Color

  attr_accessor :value, :type

  def initialize(type = nil, value = nil)
    @value = value
    @type = type
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
