#required gems
require 'pry'
require 'colorize'

# Local Classes required - all games
require_relative 'player'
require_relative 'dice'
require_relative 'heads_tails'
require_relative 'rpsls'


class Casino
  attr_accessor :player, :wallet

  def initialize
    puts
    puts 'Welcome to the Ruby Casino!'
    puts
    @player = Player.new
    # need a casino menu
    casino_menu
  end

  def casino_menu
      @valid_selection = ["0", "1", "2", "3", "4"]
      puts "*****************************************"
      puts "*                                       *"
      puts "*   WELCOME TO THE MYSTIC LAKE CASINO!  *"
      puts "*                                       *"
      puts "*   PLEASE MAKE A SELECTION TODAY...    *"   
      puts "*                                       *"     
      puts "*   1) Play Heads Tails                 *"
      puts "*   2) Play Dice                        *"
      puts "*   3) Check your wallet for money      *"
      puts "*   4) Play complimentary game RPSLS    *"      
      puts "*   0) Exit                             *"
      puts "*                                       *"
      puts "*****************************************"
      puts
      @menu_selection = gets.chomp
      # Check if selection is valid
      check_valid_menu_choice(@menu_selection)
  end

  def check_valid_menu_choice(menu_selection)
    # Go forward with choice
    if @valid_selection.include? @menu_selection
      validate_input(menu_selection)
    else 
      puts "Invalid selection. Please select something from the menu "
      casino_menu
    end
  end

  # Case statement for Operator Methods
  def validate_input(menu_selection)
    case menu_selection
      when "1"
        # Call Head Tails Game
        HeadsTails.new(@player)
      when "2"
        # Call Dice Game
        Dice.new([@player])
      when "3"
        # Check wallet balance
        @player.wallet.print_current_balance
        puts
        puts "Press Enter to Continue"
        gets
      when "4"
        # Call RPSLS Game
        RockGame.new(@player)        
      when "0"
        puts
        puts "Thanks for giving us all your money! Please come again soon!"
        puts
        puts
        exit
    end                 # end of case statement
    casino_menu  
  end                   # end of def validate_input
end                     # end of Casino class


Casino.new

