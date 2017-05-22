#required gems
require 'pry'
require 'colorize'

# Local Classes required
require_relative 'player'

class Casino
  attr_accessor :player

  def initialize
    puts 'Welcome to the Ruby Casino!'
    @player = Player.new
    binding.pry
  end
end

Casino.new
