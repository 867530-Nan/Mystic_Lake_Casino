#required gems
require 'ascii_toons'

# Local Classes required
require_relative 'wallet'

class Player
  attr_accessor :name, :age, :gender, :wallet


  def get_age
    puts
    puts "What is your age, #{@name}?"
    @age = gets.strip.to_i
      of_age(@age)
  end

  def initialize()
    puts 'What is your name?'
    @name = gets.strip
    get_age
    puts
    puts "What is your gender #{@gender}?"
    @gender = gets.strip
    # random start
    @wallet = Wallet.new 
  end

  def of_age(old)
    if old >= 21
      return
    else
      puts
      puts "Press Enter to Continue"
      gets
      ASCIIToons::Gandalf.say 'You shall not pass!'
      #puts "I am sorry, #{@name.capitalize}. You are underage & too young to play in the casino. "
      #puts "Please find a parent to escort you outside to the kiddie pool."
      puts 
      puts
      exit
    end
  end
end   # end of Player class

