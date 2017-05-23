# @author Brennick Langston
# @version 1.0.0

class Suits

  attr_reader :spades, :hearts, :clubs, :diamonds

  def initialize
    @spades = Suit.new('Spades', 1)
    @hearts = Suit.new('Hearts', 1)
    @clubs = Suit.new('Clubs', 1)
    @diamonds = Suit.new('Diamonds', 1)
  end

  def collection
    self.class_variables
  end
end
