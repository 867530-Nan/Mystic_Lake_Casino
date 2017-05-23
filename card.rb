# @author Brennick Langston
# @version 1.0.0

require_relative 'Rank'
require_relative 'Suit'

# Representation of a playing card
class Card

  attr_accessor :suit, :rank

  def initialize(suit, suit_value, rank, rank_value, rank_wild = 1)
    @suit = Suit.new(suit, suit_value)
    @suit = Rank.new(rank, rank_value, rank_wild)
  end
end
