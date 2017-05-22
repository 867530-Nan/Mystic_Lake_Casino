#required gems
require 'pry'
require 'colorize'

# Local Classes required
require_relative 'player'

class Casino
  def initialize
    puts 'Welcome to the Ruby Casino!'
    @player = Player.new
  end
end

Casino.new
