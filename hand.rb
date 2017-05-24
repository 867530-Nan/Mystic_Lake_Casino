# @author Brennick Langston
# @version 1.0.0

require_relative 'Card'

class Hand < Array

  def can_trade?
    ace = false
    each { |card| ace = card.rank.type == :ace ? true : false }
    ace ? 4 : 3
  end
end
