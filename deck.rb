# @author Brennick Langston
# @version 1.0.0

require_relative 'Suits'
require_relative 'Ranks'
require_relative 'Colors'
require_relative 'Hand'

class Deck < Array

  attr_accessor :suits, :ranks, :colors

  alias deal shift

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

  def new_hand(num_cards = 5)
    Hand.new(deal(num_cards))
    # deal(num_cards).extend(Hand)
  end
end

deck = Deck.new
hand = deck.new_hand
foot = hand.clone.shuffle!.sort!
puts 'Same Set of Cards?', hand <=> foot
puts 'Hand', hand.can_trade?, hand.is_a?(Hand)
puts 'Foot', foot.can_trade?, hand.is_a?(Hand)
