class Dice

  def initialize
    roll
  end

  def roll
    @die1 = 1 + rand(6)
    @die2 = 1 + rand(6)
  end

  def show_dice
    print "Die 1: ", @die1, " Die 2: ", @die2
  end

  def show_sum
    print "Sum of dice is: ", @die1 + @die2, ".\n"
  end
end
