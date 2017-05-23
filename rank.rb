# @author Brennick Langston
# @version 1.0.0

class Rank

  attr_accessor :type, :value

  def initialize(type = nil, value = nil, wild = 1)
    @type = type
    @value = value
    @wild = wild
  end
end
