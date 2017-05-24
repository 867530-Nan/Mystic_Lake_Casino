# @author Brennick Langston
# @version 1.0.0
# @todo More than one winner detected, split earnings

require 'pry'
require 'colorize'
require 'tty'

# require_relative 'Wallet'

# Rolling Dice Street Game
class Dice

  attr_accessor :ante, :bet, :players

  # Initializer for class Dice
  # @param players [Array] array of player objects
  # @param ante [Float] the ante required to be in the game
  # @return nil
  def initialize(players = [], ante = 20.00)
    @ante = ante
    @players = {}
    players.is_a?(Array) ? join_game(players) : join_game([players])
    @prompt = TTY::Prompt.new
    show_menu
  end

  # Displays a simple menu when starting the dice game
  # @return nil
  def show_menu
    puts "\e[2J"
    puts '-' * 50
    puts "\n"
    puts format '%3s%s', ' ', 'Welcome to Street Craps!'.green
    puts format '%3s%s', ' ', "\n"
    puts format '%3s%s', ' ', 'Here are the rules:'
    puts format '%3s%s', ' ', '1) Set your ante'
    puts format '%3s%s', ' ', '2) Make a bet (select a combination)'
    puts format '%3s%s', ' ', '3) Roll the dice'
    puts format '%3s%s', ' ', '4) Reap your earning for beating the odds'
    puts format '%3s%s', ' ', '6) Repeat!'
    puts format '%3s%s', ' ', '5) Call Social Services for financial assistance'
    puts format '%3s%s', ' ', "\n"
    puts '   How to Place a Bet'.green
    puts '   > Pass - Dice sum to 7 or 11'.yellow
    puts '   > Don\'t Pass - Dice sum to 2, 3, or 12'.yellow
    puts '   > Points - Dice sum to 4, 5, 6, 8, 9, or 10'.yellow
    puts '   * Player loses with all other sums'.yellow
    puts "\n"
    puts format '%3s%s', ' ', 'Hit the [Enter Key] to try your luck!'
    gets
    # puts "\e[2J"
    rounds = @prompt.ask("   Enter the number rounds to be played:\s".red, convert: :int)
    play_round(rounds)
  end

  # Helper Method for clearing the terminal sceen
  # @return nil
  def clear_screen
    puts "\e[2J"
  end

  def spacer(new_lines = 1)
    puts "\n" * new_lines.to_i
  end

  # Displays the players amounts that are left in their wallets (aka. cash flow)
  # @return nil
  def show_wallets
    clear_screen
    @prompt.say("++++++++++++++++++ Players Wallets ++++++++++++++++++")
    @players.each do |player, data|
      points = @players[player][:points]
      wallet = player.wallet.amount
      @prompt.say("#{player.name}\shas\s$#{wallet} and #{points} points")
    end
    spacer(3)
  end

  # Obtains the bet that the player is going to place on the next round of dice
  # @param player [Player] a single player object of the game
  # @return [Integer]
  def place_bet(player)
    clear_screen
    puts '   How to Place a Bet'.green
    puts '   > Pass - Dice sum to 7 or 11'.yellow
    puts '   > Don\'t Pass - Dice sum to 2, 3, or 12'.yellow
    puts '   > Points - Dice sum to 4, 5, 6, 8, 9, or 10'.yellow
    puts '   * Player loses with all other sums'.yellow
    puts "\n"
    question = "What is #{player.name}\'s bet? " +
      "[ Enter: 1 for pass, 2 for don\'t pass, 3 for points]\s"
    bet = @prompt.ask(question, convert: :int)
    bet
  end

  # Obtains the ante for the next set of rounds from each player
  # @param player [Player] a single player object placing the ante
  # @return [Integer]
  def place_ante(player)
    show_wallets
    ante = @prompt.ask("What is #{player.name}\'s ante?\s", convert: :float)
    max_ante = player.wallet.amount
    out_of_funds(player) if ante > max_ante || max_ante.zero?
    ante
  end

  # Determines if a player is out of funds and will go in debt
  # @param player [Player] a single player object of the game
  # @return nil
  def out_of_funds(player)
    clear_screen
    puts "#{player.name.capitalize}!!!\s Your out of Money.".red
    puts 'This doesn\'t matter, we\'ll let you go in debt any!'.green
    puts "\n"
    @prompt.ask('Hit the [Enter] key..'.yellow)
    # gets
  end

  # Rolls the dice and gives back some random numbers for each die
  # @return nil
  def roll
    @die1 = 1 + rand(6)
    @die2 = 1 + rand(6)
  end

  # Displays the values of each die when they were rolled
  # @return nil
  def show_dice
    @prompt.say("Die 1 = #{@die1}\nDie 2 = #{@die2}".yellow)
  end

  # Displays the sum of the two die
  # @return
  def show_sum
    @prompt.say("Dice Sum: #{@die1 + @die2}")
  end

  # Determines who and when players can join a round of the game
  # @param players [Player] array or single player to add into the game
  # @return nil
  def join_game(players)
    if can_join? && players.any?
      players.each do |player|
        @players[player] = { points: 0, earnings: 0.0, ante: 0.0, win: false }
      end
    end
  end

  # Calculates if the timming is right to be able to join the game
  # @return bool
  def can_join?
    sum = 0
    @players.keys.each do |player|
      sum += @players[player][:points]
    end
    sum.zero? # can join if all points are zero
  end

  # Resets the points for each player to zero
  # @return nil
  def clear_points
    @players.values.each { |data| data[:points].clear }
  end

  # Main Method for running and determining the outcome of a roll of the dice
  # @param player [Player] a single player object who's turn it is to play
  # @param bet [Integer] number indicating the desired sum of the dice for a win
  # @param return nil
  def win_lose?(player, bet)
    show_sum
    show_dice
    sum = @die1 + @die2
    case sum.to_s
    when /[7|11]/ # pass
      bet == 1 ? winner(player, 3) : loser(player, 3)
    when /[2|3|12]/ # don't pass
      bet == 2 ? winner(player, 2) : loser(player, 2)
    when /[4|5|6|8|9|10]/ # carry over
      bet == 3 ? winner(player) : loser(player)
    else
      loser(player)
    end
    @prompt.ask('Press [Enter] key to continue..')
  end

  # Sets the points gain for a single player from their roll of dice
  # @param player [Player] a single player object of the winner
  # @param points [Integer] number of points that the player will accrue
  # @return nil
  def winner(player, points = 1)
    @players[player][:points] += points
    @players[player][:win] = true
    @prompt.say("#{player.name} Scored #{points} points!!!!!".green)
  end

  # Sets the points lost for a single player from their roll of dice
  # @param player [Player] a single player object of the loser
  # @param points [Integer] number of points lost by the player
  # @return nil
  def loser(player, points = 1)
    if @players[player][:points] - points > 0
      @players[player][:points] -= points
    elsif @players[player][:points] > 0
      @players[player][:points] = 0
    end
    @players[player][:win] = false
    @prompt.say("#{player.name} Lost #{points} points.".red)
  end

  # Initiates a number of rounds played for the given set of players
  # @param rounds [Integer] number of rounds to be played before accruing antes
  # @return nil
  def play_round(rounds = 1)
    show_wallets
    @players.keys.each do |player|
      @players[player][:ante] = place_ante(player)
    end
    (1..rounds).each {
      @players.keys.each do |player|
        roll
        win_lose?(player, place_bet(player))
      end
    }
    see_bookie
    quit_game?
  end

  # Quietly returns the state of the game back to the main Casino application
  # @return nil
  def quit_game?
    print "Quit?\s(y/N)\s"
    yN = gets
    yN =~ /[y|Y|yes|Yes]/ ? return : play_round
  end

  # The Bookie determines whether a player wins or loses their ante after a
  # round of craps. Also, assigns winnings back into a players wallet
  # @return nil
  def see_bookie
    winners, earnings, winners_pot = high_points_winner
    # share = earnings/winners.count
    winners.each do |winner|
      percent_of_earnings = @players[winner][:ante]/winners_pot
      @players[winner][:earnings] = earnings * percent_of_earnings
      winner.wallet.amount += earnings * percent_of_earnings
    end
    show_winner_info(winners)
  end

  # Determines who the high points winner is. Removes losers ante from
  # their wallet and returns the winnings (pot) to the bookie for assigning
  # back to the winner.
  # @return winner [Player] a single players object reference
  # @return earnings [Float] dollars earned by winning
  def high_points_winner
    high_pointers = find_highest_points
    earnings = 0.0
    winners = []
    winners_pot = 0.0
    @players.each do |player, data|
      if high_pointers.include?(player) && @players[player][:win]
        winners << player
        winners_pot += @players[player][:ante]
      end
      earnings += data[:ante]
      player.wallet.amount -= data[:ante]
    end
    [winners, earnings, winners_pot]
  end

  # Determines who the winner or highest points holder is
  # @return winner [Player] single player object of winner
  def find_highest_points
    highest = -1
    @players.each do |player, data|
      if data[:points] > highest
        highest = data[:points]
      end
    end
    @players.select { |player, data| data[:points] == highest }
  end

  # Displays the winners informations
  # @param winner [Player] single player object of the winner
  # @return nil
  def show_winner_info(winners)
    output = nil
    winners.each do |winner|
      points = @players[winner][:points]
      earnings = format("%.2f", @players[winner][:earnings])
      clear_screen
      output = "Points Leader:\s#{winner.name}\swith #{points}\s" +
        "points and $#{earnings} in earnings"
    end
    output = 'No Winners! Play Next Round.' if winners.empty?
    clear_screen
    @prompt.say(output)
  end

end

# class Player
#   attr_accessor :name, :age, :gender, :wallet
#   def initialize(name, age, gender)
#     @name = name
#     @age = age
#     @gender = gender
#     @wallet = Wallet.new
#   end
# end
#
# players = [
#   Player.new('Jennifer', 34, 'female'),
#   Player.new('Brennick', 21, 'male'),
#   Player.new('Francis', 34, 'female')
# ]
#
# Dice.new(players)
