# @todo Implement the wallet class

class Player
  attr_accessor :name, :age, :gender

  def initialize(name = nil, age = 0, gender = nil)
    @name = name
    @age = age
    @gender = gender
    # let's not put questions in the class. we'll talk about this later
    puts 'What is your name?'
    @name = gets.strip
    puts "What is your age #{@name}?"
    @age = gets.strip.to_i
    puts "What is your gender #{@gender}?"
    @gender = gets.strip
  end
end
