# @author Brennick Langston
# @version 1.0.0

require_relative 'Suit'

class Suits < Array

  attr_reader :spades, :hearts, :clubs, :diamonds

  def initialize
    super
    @spades = Suit.new(:spades, 1)
    push(@spades)
    @hearts = Suit.new(:hearts, 1)
    push(@hearts)
    @clubs = Suit.new(:clubs, 1)
    push(@clubs)
    @diamonds = Suit.new(:diamonds, 1)
    push(@diamonds)
  end
end
