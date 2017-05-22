# @todo Implement the wallet class
require_relative 'wallet'

class Player
  attr_accessor :name, :age, :gender, :wallet

  def initialize()
    puts 'What is your name?'
    @name = gets.strip
    puts "What is your age, #{@name}?"
    @age = gets.strip.to_i
    puts "What is your gender #{@gender}?"
    @gender = gets.strip
    # random start
    @wallet = Wallet.new 
  end

  def is_of_age?
    @age > 21
  end
end
