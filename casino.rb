#required gems
require 'pry'
require 'colorize'

# Local Classes required - all games
require_relative 'player'
require_relative 'game_1'

class Casino
  attr_accessor :player

  def initialize
    puts 'Welcome to the Ruby Casino!'
    @player = Player.new
    # need a casino menu
    casino_menu
  end

  def casino_menu
  	puts "This is the menu."
  	# puts "1) Game Selection"
  	# puts "2) Open your wallet"
  	# puts "3) Go to the bar"
  	HeadsTails.new(player)
  end
end

Casino.new
