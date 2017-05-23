require 'pry'


class Roulette

	attr_accessor :player, :wallet

	@bet_options = ['1st 12', '2nd 12', '3rd 12', '1 to 18', 'Even', 'Red', 'Black', 'Odd', '19 to 36']
	@pot = []
	@players = {}
	@player_1 = []
	@landing_spot = []


	@croupier = [
		{color: 'red', number: 1}, 
		{color: 'red', number: 3}, 
		{color: 'red', number: 5}, 
		{color: 'red', number: 7}, 
		{color: 'red', number: 9}, 
		{color: 'red', number: 12}, 
		{color: 'red', number: 14}, 
		{color: 'red', number: 16}, 
		{color: 'red', number: 18}, 
		{color: 'red', number: 19}, 
		{color: 'red', number: 21}, 
		{color: 'red', number: 23}, 
		{color: 'red', number: 25}, 
		{color: 'red', number: 27}, 
		{color: 'red', number: 30}, 
		{color: 'red', number: 32}, 
		{color: 'red', number: 34},
		{color: 'red', number: 36},
		{color: 'black', number: 2},
		{color: 'black', number: 4},
		{color: 'black', number: 6},
		{color: 'black', number: 8},
		{color: 'black', number: 11},
		{color: 'black', number: 13},
		{color: 'black', number: 15},
		{color: 'black', number: 17},
		{color: 'black', number: 20},
		{color: 'black', number: 22},
		{color: 'black', number: 24},
		{color: 'black', number: 26},
		{color: 'black', number: 28},
		{color: 'black', number: 29},
		{color: 'black', number: 31},
		{color: 'black', number: 33},
		{color: 'black', number: 35},
		{color: 'black', number: 36}]

	def initialize(player)
		@player = player
		puts "\n\n\n\n\n\n\n\n\n\n\n***********#{@player.name}, Welcome to the dizzying world of Roulette************"
		puts "You currently have $#{@player.wallet.amount} in your account"
		roulette_menu
	end

	def create_character
		@players.each {|player| earnings: 0.0, win: false, wager: 0.0, bet: 'string'}
	end

	def pay_out
		
	end

	def play_roulette
		@landing_spot = @croupier.sample
		puts "Dealer calls out the tables picks.."
		puts "#{@player}, #{@player_1}!"
		@players.each {|value| puts "#{@players.name}, #{@players[:bet]}"}
		puts "Dealer spins the wheel, drops the ball, and the crowd goes silent"
		puts "\n\n\n\n\n\n\nThe ball loses momentum, bangs around, and slowly lands on it's spot"
		puts "The Dealer Calls: #{@landing_spot[:color]}, #{@landing_spot[:number]}"
		puts "The crowd goes wild!!"
		pay_out
	end

	def betting
		puts "Betting Options:"
		@bet_options.each_with_index {|bet, index| indexplusone = index + 1 puts "#{indexplusone}: #{bet}"}
		puts "Place your bet [1 through 9].."
		place_bet
		puts "And what's your wager?"
		wager_amount
		play_roulette
	end


	def place_bet
		betting_clone = @bet_options.clone
		case gets.chomp.to_s
		when '1'
			@player_1.push(betting_clone[0])
		when '2'
			@player_1.push(betting_clone[1])
		when '3'
			@player_1.push(betting_clone[2])
		when '4'
			@player_1.push(betting_clone[3])
		when '5'
			@player_1.push(betting_clone[4])
		when '6'
			@player_1.push(betting_clone[5])
		when '7'
			@player_1.push(betting_clone[6])
		when '8'
			@player_1.push(betting_clone[7])
		when '9'
			@player_1.push(betting_clone[8])
		else
			puts "Sorry I did not understand... Please "
		end
		random_bet1 = betting_clone.sample
		@player_2.push = random_bet1
		random_bet2 = betting_clone.sample
		@player_2.push = random_bet2
		random_bet3 = betting_clone.sample
		@player_3.push = random_bet3
		random_bet4 = betting_clone.sample
		@player_4.push = random_bet4
		@players.each { |player| @players[:bet] = @betting_clone.sample }
	end

	def wager_amount
		puts "#{@player.name}, you're currently at the Roulette table with $#{@player.wallet.amount}\nHow much would you like to wager??"
		wager = gets.chomp.to_i
		@player.wallet.amount - wager
		@players.each { |player| @players[:wager] = @players.wallet.amount.to_f / 5}
		x = @players.each{|player| @player[:wager]}
		@pot = wager + x
	end


	def roulette_menu
		puts "\n\n\n\n\nWhat would you like to:"
		puts "1) Play Roulette"
		puts "2) Learn about the game"
		puts "3) Watch a game"
		puts "4) Back to Casino Lobby"
		case gets.chomp.to_i 
		when 1
			puts "Let's Play Roulette!!"
			betting
		when 2 
			rules_roulette
		when 3 
			watch_roulette
		when 4
			return
		else 
			puts "Sorry, I did not understand that.."
			roulette_menu
		end
	end

end








class RandomChars
	attr_accessor :name, :age, :wallet

	def initialize (name, age, wallet)
		@age = age
		@name = name
		@wallet = Wallet.new
	end
end

players = [
RandomChars.new('Bradley Cooper', 43),
RandomChars.new('Sharon Osborn', 74),
RandomChars.new('James Taylor', 75),
RandomChars.new('Harry Potter', 17)
]

Roulette.new(players)


array.each { |player| player.wallet.amount }




