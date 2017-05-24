# @author Brennick Langston
# @version 1.0.0

require_relative 'Rank'
require_relative 'Suit'

# Representation of a playing card
class Card

  attr_accessor :suit, :rank, :color

  def initialize(suit, rank, color)
    @suit = suit
    @rank = rank
    @color = color
  end

  def ==(other)
    @suit == other.suit && @rank == other.rank && @color == other.color
  end

  def >(other)
    @suit > other.suit && @rank > other.rank && @color > other.color
  end

  def <(other)
    @suit < other.suit && @rank < other.rank && @color < other.color
  end

  def <=>(other)
    [@suit, @rank, @color] <=> [other.suit, other.rank, other.color]
  end
end
