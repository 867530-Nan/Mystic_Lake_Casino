# @author Brennick Langston
# @version 1.0.0

require_relative 'Color'

class Colors

  attr_accessor :red, :black

  def initialize
    @red = Color.new('Red', 1)
    @black = Color.new('Black', 1)
  end
end
