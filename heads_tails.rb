require 'pry'
require 'colorize'

class HeadsTails

	def initialize(player)
		@player = player
		h_t_options
	end

	def h_t_options
		puts "\n\n\n\n\n\n\n\n"
		puts "Welcome to Heads - Tails"
		puts "#{@player.name} you have a balance of $#{@player.wallet.amount}."
		puts "Heads - Tails costs $20 for 1 play"
		puts "Please select an option:"
		puts "1) Play Heads - Tails"
		puts "2) Read the Rules of Heads - Tails"
		puts "3) Go back to Casino Lobby" 
		puts "Enter 1, 2, or 3"
		case gets.chomp.to_i
		when 1 
			puts "\n\n\n\n"
			puts "Let's have some fun!"
			wallet_check
		when 2
			h_t_rules
		when 3
			puts "Goodbye"
			return
		else 
			puts "Sorry, I did not understand that"
			h_t_options
		end
		return
	end

	def wallet_check
		if @player.wallet.amount > 20
			h_t_game
		else
			puts "\n\n\n\n\n"
			puts "Sorry, you only have $#{@player.wallet.amount} unable to spend your money here"
			return
		end
	end

	def place_bet
		puts "$20 ante's are collected"
		@player.wallet.amount -= 20.0
	end

	def h_t_rules
		puts "\n\n\n\n\n\n\n\n\n\n\n\n"
		puts "Rules of the game:"
		puts "Heads and Tails is an ancient game, dating back to the Mesozoic Era."
		puts "The Basics are:"
		puts "Pick either heads or tails, and if it matches what the dealer chooses, you win."
		puts "Plain and Simply. Enjoy the game!!"
		h_t_options
	end


	def h_t_game
		place_bet
		ht = [1, 2]
		dealer = ht.sample
		puts "Do you choose 1) Heads or 2) Tails [1, 2]"
		fun = gets.chomp.to_i
		if fun == dealer
			puts "The dealer shows #{dealer}"
			puts "#{@player.name} show #{fun}"
			win_game
		elsif fun != dealer
			puts "The dealer shows #{dealer}"
			puts "#{@player.name} show #{fun}"
			lose_game
		else
			puts "Sorry, we couldn't understand you."
			puts "Someone has had a little too much to drink."
			puts "You lose $20"
			h_t_options
		end
	end

	def win_game
		@player.wallet.amount += 20
		puts "Congratulations on the big win"
		puts "You've just won $20"
		h_t_options
	end

	def lose_game
		puts "Someone could use a lesson in Telepathy.\nBetter luck next time"
		h_t_options
	end


end

