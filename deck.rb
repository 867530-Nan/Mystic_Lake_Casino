# @author Brennick Langston
# @version 1.0.0

require_relative 'Card'
require_relative 'Suits'
require_relative 'Ranks'

class Deck < Array

  attr_accessor :suits, :ranks

  def initialize
    super
    @suits = Suits.new
    @ranks = Ranks.new
    generate_deck
  end

  def generate_deck
    @suits.each do |suit|
      @ranks.each do |rank|
        color = suit == @suits.spades || suit == @suits.clubs ? :black : :red
        push(Card.new(suit, rank, color))
      end
    end
  end
end

deck = Deck.new
p deck
gets
deck.shuffle!
p deck
gets
