require 'pry'
require 'colorize'


class HeadsTails


	def initialize(player)
		puts "Welcome to Heads - Tails"
		puts "#{player.name} you have a balance of #{player.wallet.amount}"
	end
end
