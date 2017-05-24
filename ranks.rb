# @author Brennick Langston
# @version 1.0.0

require_relative 'Rank'

class Ranks < Array

  attr_reader :ace, :two, :three, :four, :five, :six, :seven, :eight
  attr_reader :nine, :ten, :jack, :queen, :king

  def initialize
    @ace = Rank.new(:ace, 1, 14)
    push(@ace)
    @two = Rank.new(:two, 2)
    push(@two)
    @three = Rank.new(:three, 3)
    push(@three)
    @four = Rank.new(:four, 4)
    push(@four)
    @five = Rank.new(:five, 5)
    push(@five)
    @six = Rank.new(:six, 6)
    push(@six)
    @seven = Rank.new(:seven, 7)
    push(@seven)
    @eight = Rank.new(:eight, 8)
    push(@eight)
    @nine = Rank.new(:nine, 9)
    push(@nine)
    @ten = Rank.new(:ten, 10)
    push(@ten)
    @jack = Rank.new(:jack, 11)
    push(@jack)
    @queen = Rank.new(:queen, 12)
    push(@queen)
    @king = Rank.new(:king, 13)
    push(@king)
  end
end
