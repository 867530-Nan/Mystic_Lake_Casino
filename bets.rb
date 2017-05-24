# @author Brennick Langston
# @version 1.0.0

require_relative 'Bet'

class Bets

  attr_accessor :raise, :fold, :call, :check

  def initialize
    @raise = Bet.new('Raise')
    @fold = Bet.new('Fold')
    @call = Bet.new('Call')
    @check = Bet.new('Check')
  end
end
