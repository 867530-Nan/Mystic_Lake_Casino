class Dice

  attr_accessor :ante, :bet, :players

  def initialize(players = [], ante = 20.00)
    @ante = ante
    @players = {}
    join_game(players)
  end

  def place_bet
    print "What is your bet? [1 for pass, 2 for don\'t pass, 3 for points]\s"
    gets.strip.to_i
  end

  def place_ante
    print "What is your ante?\s"
    gets.strip.to_f
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

  def join_game(players)
    @players.each { |player| @players[player][:points] = 0 } if can_join? && players.any?
  end

  def can_join?
    sum = 0
    @players.keys.each do |player|
      sum += @players[player][:points]
    end
    sum.zero? # can join if all points are zero
  end

  def win_lose?(player, bet)
    case @die1 + @die2
    when 7 || 11 # pass
      bet == 1 ? winner(player, 3) : loser(player, 3)
    when 2 || 3 || 12 # don't pass
      bet == 2 ? winner(player, 2) : loser(player, 2)
    when 4 || 5 || 6 || 8 || 9 || 10 # carry over
      bet == 3 ? winner(player) : loser(player)
    else
      loser(player)
    end
  end

  def winner(player, point = 1)
    @players[player][:points] += point
  end

  def loser(player, point = 1)
    @players[player][:points] -= point
  end

  def play_round
    @players.keys.each do |player|
      @players[player][:ante] = place_ante
    end
    @players.keys.each do |player|
      roll
      win_lose?(player, place_bet)
    end
  end
end
