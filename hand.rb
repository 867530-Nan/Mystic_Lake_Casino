# @author Brennick Langston
# @version 1.0.0

require_relative 'Card'

class Hand < Array

  alias high_card max
  alias low_card min

  def can_trade?
    ace = false
    each { |card| ace = card.rank.type == :ace ? true : false }
    ace ? 4 : 3
  end

  def pairs

end
