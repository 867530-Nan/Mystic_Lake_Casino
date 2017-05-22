# @author Brennick Langston
# @version 1.0.0

# Rolling Dice Street Game
class Dice

  attr_accessor :ante, :bet, :players

  # Initializer for class Dice
  # @param players [Array] array of players
  # @param ante [Float] the ante required to be in the game
  # @return nil
  def initialize(players = [], ante = 20.00)
    @ante = ante
    @players = {}
    players.is_a?(Array) ? join_game(players) : join_game([players])
    play_round
  end

  def place_bet
    print "What is your bet? [1 for pass, 2 for don\'t pass, 3 for points]\s"
    ans = gets.strip.to_i
    ans
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
    if can_join? && players.any?
      players.each do |player|
        @players[player] = { points: 0, earnings: 0, ante: 0 }
      end
    end
  end

  def can_join?
    sum = 0
    @players.keys.each do |player|
      sum += @players[player][:points]
    end
    sum.zero? # can join if all points are zero
  end

  def clear_points
    @players.values.each { |data| data[:points].clear }
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

  def loser(player, points = 1)
    if @players[player][:points] - points >= 0
      @players[player][:points] -= points
    end
  end

  def play_round(rounds = 1)
    @players.keys.each do |player|
      @players[player][:ante] = place_ante
    end
    (1..rounds).each {
      @players.keys.each do |player|
        roll
        win_lose?(player, place_bet)
      end
    }
    see_bookie
    quit_game?
  end

  def quit_game?
    print "Quit?\s(y/N)\s"
    yN = gets
    yN =~ /[y|Y|yes|Yes]/ ? exit : play_round
  end

  def see_bookie
    winner, earnings = high_points_winner
    @players[winner][:earnings] = earnings
    show_winner_info(winner)
  end

  def high_points_winner
    highest_points = find_highest_points
    earnings = 0
    winner = nil
    @players.each do |player, data|
      if data[:points] == highest_points
        winner = player
        earnings += @players[winner][:ante] if @players.keys.count == 1
      else
        earnings += data[:ante]
        player.wallet.amount -= data[:ante]
      end
    end
    [winner, earnings]
  end

  def find_highest_points
    highest = 0
    @players.values.each do |data|
      highest = data[:points] if data[:points] > highest
    end
    highest
  end

  def show_winner_info(winner)
    points = @players[winner][:points]
    earnings = @players[winner][:earnings]
    puts "Points Leader:\s#{winner.name}\swith #{points} points and $#{earnings}"
  end

end
