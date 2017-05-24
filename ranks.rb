# @author Brennick Langston
# @version 1.0.0

require_relative 'Rank'

class Ranks < Array

  attr_reader :ace, :two, :three, :four, :five, :six, :seven, :eight
  attr_reader :nine, :ten, :jack, :queen, :king

  def initialize
    @ace = Rank.new('Ace',1,14)
    push(@ace)
    @two = Rank.new('Two',2)
    push(@two)
    @three = Rank.new('Three',3)
    push(@three)
    @four = Rank.new('Four',4)
    push(@four)
    @five = Rank.new('Five',5)
    push(@five)
    @six = Rank.new('Six',6)
    push(@six)
    @seven = Rank.new('Seven',7)
    push(@seven)
    @eight = Rank.new('Eight',8)
    push(@eight)
    @nine = Rank.new('Nine',9)
    push(@nine)
    @ten = Rank.new('Ten',10)
    push(@ten)
    @jack = Rank.new('Jack',11)
    push(@jack)
    @queen = Rank.new('Queen',12)
    push(@queen)
    @king = Rank.new('King',13)
    push(@king)
  end
end
