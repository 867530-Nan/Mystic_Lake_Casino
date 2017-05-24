# @author Brennick Langston
# @version 1.0.0

require_relative 'Card'
require_relative 'Suits'
require_relative 'Ranks'
require_relative 'Colors'

class Deck < Array

  attr_accessor :suits, :ranks

  alias :deal :shift

  def initialize
    super
    @suits = Suits.new
    @ranks = Ranks.new
    @colors = Colors.new
    new_deck
  end

  def new_deck
    @suits.each do |suit|
      @ranks.each do |rank|
        color = suit == @suits.spades || suit == @suits.clubs ? @colors.black : @colors.red
        push(Card.new(suit, rank, color))
      end
    end
    shuffle
  end
end

deck = Deck.new
hand = deck.deal(5)
foot = deck.deal(5)
puts hand <=> foot
