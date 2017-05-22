#required gems
require 'pry'
require 'colorize'

# Local Classes required - all games
require_relative 'player'
#require_relative 'dice'
require_relative 'heads_tails'

class Casino
  attr_accessor :player, :wallet

  def initialize
    puts 'Welcome to the Ruby Casino!'
    @player = Player.new
    # need a casino menu
    casino_menu
  end

  def casino_menu
      @valid_selection = ["1", "2", "3", "4"]
      puts "*****************************************"
      puts "*                                       *"
      puts "*   WELCOME TO THE MYSTIC LAKE CASINO!  *"
      puts "*                                       *"
      puts "*   PLEASE MAKE A SELECTION TODAY...    *"   
      puts "*                                       *"     
      puts "*   1) Play Heads Tails                 *"
      puts "*   2) Play Dice                        *"
      puts "*   3) Check your wallet for money      *"      
      puts "*   4) Exit                             *"
      puts "*                                       *"
      puts "*****************************************"
      puts
      @menu_selection = gets.chomp
      # Check if selection is valid
      check_valid_menu_choice
  end
end

def check_valid_menu_choice
    # Go forward with choice
    if @valid_selection.include? @menu_selection
      validate_input
    else 
      puts "Invalid selection. Please select something from the menu "
      casino_menu
    end
end

# Case statement for Operator Methods
def validate_input
  case @menu_selection
    when "1"
    # Call Head Tails Game
    HeadsTails.new(player)
    when "2"
    Dice.new(player)
    when "3"
      current_balance
    when "4"
      exit
  end
end





Casino.new

