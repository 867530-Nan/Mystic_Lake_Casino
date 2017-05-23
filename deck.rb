# @author Brennick Langston
# @version 1.0.0

require_relative 'Card'
require_relative 'Suit'
require_relative 'Rank'

class Deck

  attr_accessor :stack

  def initialize
    create_spades
    create_diamonds
    create_clubs
    create_hearts
  end

  def create_spades
    @stack << Card.new(:A,1,:spades,1,12)
    @stack << Card.new(:two,2,:spades,1)
    @stack << Card.new(:three,3,:spades,1)
    @stack << Card.new(:four,4,:spades,1)
    @stack << Card.new(:five,5,:spades,1)
