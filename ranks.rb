# @author Brennick Langston
# @version 1.0.0

class Ranks

  attr_reader :ace, :two, :three, :four, :five, :six, :seven, :eight
  attr_reader :nine, :ten, :jack, :queen, :king

  def initialize
    @ace = Rank.new('Ace',1,12)
    @two = Rank.new('Two',2)
    @three = Rank.new('Three',3)
    @four = Ranks.new('Four',4)
    @five = Rank.new('Five',5)
    @six = Rank.new('Six',6)
    @seven = Rank.new('Seven',7)
    @eight = Rank.new('Eight',8)
    @nine = Rank.new('Nine',9)
    @ten = Rank.new('Ten',10)
    @jack = Rank.new('Jack',11)
    @queen = Rank.new('Queen',12)
    @king = Rank.new('King',13)
  end
end
