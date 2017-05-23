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
    show_menu
  end

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
    play_round
  end

  def show_wallets
    puts "\e[2J"
    puts "++++++++++++++++++ Players Wallets ++++++++++++++++++"
    @players.each do |player, data|
      points = @players[player][:points]
      wallet = player.wallet.amount
      puts "#{player.name}\shas\s$#{wallet} and #{points} points"
    end
    puts "\n"
  end

  def place_bet(player)
    print "What is #{player.name}\'s bet? " +
      "[ Enter 1 for pass, 2 for don\'t pass, 3 for points]\s"
    ans = gets.strip.to_i
    ans
  end

  def place_ante(player)
    show_wallets
    print "What is your ante?\s"
    ante = gets.strip.to_f
    max_ante = player.wallet.amount
    out_of_funds(player) if ante > max_ante && !max_ante.zero?
    ante
  end

  def out_of_funds(player)
    puts "\e[2J"
    puts "#{player.name.capitalize}!!!\s Your out of Money.".red
    puts 'Please Visit the closest ATM and Load Your Wallet to continue.'.green
    puts "\n\n"
    puts "Hit the [Enter] key..".yellow
  end

  def roll
    @die1 = 1 + rand(6)
    @die2 = 1 + rand(6)
  end

  def show_dice
    puts "Die 1 = #{@die1}\nDie 2 = #{@die2}"
  end

  def show_sum
    puts "Dice Sum: #{@die1 + @die2}."
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
  end

  def winner(player, points = 1)
    @players[player][:points] += points
  end

  def loser(player, points = 1)
    if @players[player][:points] - points > 0
      @players[player][:points] -= points
    elsif @players[player][:points] > 0
      @players[player][:points] = 0
    end
  end

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

  def quit_game?
    print "Quit?\s(y/N)\s"
    yN = gets
    yN =~ /[y|Y|yes|Yes]/ ? return : play_round
  end

  def see_bookie
    winner, earnings = high_points_winner
    @players[winner][:earnings] += earnings
    show_winner_info(winner)
  end

  def high_points_winner
    highest_points = find_highest_points
    earnings = 0
    winner = nil
    @players.each do |player, data|
      if data[:points] == highest_points
        winner = player
        if @players.keys.count == 1 && highest_points > 0
          earnings -= @players[winner][:ante]
        end
      else
        earnings += data[:ante]
        player.wallet.amount -= data[:ante]
      end
    end
    [winner, earnings]
  end

  def find_highest_points
    highest = -1
    @players.values.each do |data|
      highest = data[:points] if data[:points] > highest
    end
    highest
  end

  def show_winner_info(winner)
    points = @players[winner][:points]
    earnings = @players[winner][:earnings]
    puts "Points Leader:\s#{winner.name}\swith #{points} points and $#{earnings} earnings"
  end

end
