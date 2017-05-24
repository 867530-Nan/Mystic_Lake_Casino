#require_relative 'player'

#class GuessNumber
 #   def initialize(player)
 #       @player = player
 #       display
  #  end

    def instructions
        puts
        puts "Can you guess the number?"
        puts
        puts "OMG, this feels like a carnival, not a casino!" 
        puts 
        display
    end

# Operator Menu
    def display
        puts
        puts "********************************************************"
        puts "*                                                      *"
        puts "*                                                      *"
        puts "*      WELCOME TO THE COMPLIMENTARY GAME:              *"
        puts "*                                                      *"
        puts "*      GUESS THE NUMBER!                               *"
        puts "*                                                      *"
        puts "*      Please select one of these choices:             *"
        puts "*                                                      *"
        puts "*      Enter 'p' to play                                *"                                         
        puts "*                                                      *"
        puts "*      Enter 'i' for instructions                      *"
        puts "*      Enter 'q' to quit                               *"
        puts "********************************************************"
        puts
        @game_choice= gets.chomp
        error_check(@game_choice)
    end

    def error_check(choice)
        if choice == 'p'
            guess_num
        else
            if choice == "i"
                instructions
            elsif choice == "q"
                return
            else
                puts "Input is case senstive. The choices are 'p', 'i', and 'q'"
                puts
                display
            end
        end
    end

    def guess_num
        # computer generate random number 
        @random_number = rand(1..100)
        puts "We have picked a random number out of hat. Guess a number between 1 and 100, inclusive"
        guess = gets.to_i
        check_valid(guess)
        result(guess)
    end    

    class String
        def is_integer
            self.to_i.to_s == self
        end
    end

    def check_valid(guess)
        # (1..10) === i
        if guess.between?(1,100)
            result(guess)
        else
            puts "Easy Peasy Game, Just pick a random number between 1 and 100."
            guess = gets.chomp
            return check_num(guess)
        end
    end

    def result(guess)
       puts "Random number was: " 
       puts @random_number
       if guess == @random_number
           puts "Wow! You won! Are you a mind reader or have special powers?"
        else
            puts "Good guess, but not the right one! Better luck next time!"
        end
    end

#end
#Guess.new(@player)

display