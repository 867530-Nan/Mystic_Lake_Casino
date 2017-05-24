require_relative 'player'

class RockGame
    def initialize(player)
        @player = player
        display
    end

    # The key idea of this program is to equate the strings
    # "rock", "paper", "scissors", "lizard", "Spock" to numbers
    # as follows:
    #
    # 0 - rock
    # 1 - Spock
    # 2 - paper
    # 3 - lizard
    # 4 - scissors

    def instructions
        puts
        puts "Sheldon Cooper (Big Bang Theory) explains the game Rock, Paper, Scissors, Lizard, Spock (RPSLS)"
        puts
        puts "Scissors cuts paper, paper covers rock." 
        puts "rock crushes lizard, lizard poisons Spock."
        puts "Spock smashes scissors, scissors decapitates lizard."
        puts "lizard eats paper, paper disproves Spock."
        puts "Spock vaporizes rock, and as it always has, rock crushes scissors."
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
        puts "*                     RPSLS                            *"
        puts "*                                                      *"
        puts "*      Please select one of these choices:             *"
        puts "*                                                      *"
        puts "*      rock, paper, scissors, lizard, Spock!           *"                                         
        puts "*                                                      *"
        puts "*      Enter 'i' for instructions                      *"
        puts "*      Enter 'q' to quit                               *"
        puts "********************************************************"
        puts
        @game_choice= gets.chomp
        error_check(@game_choice)
    end

    def error_check(choice)
        # Check if input is "rock", "paper", "scissors", "lizard", "Spock"
        # if params[:test] =~ /foo/
        if choice =~ /(rock|paper|scissors|lizard|Spock)/
            rpsls(choice)
        else
            if choice == "i"
                instructions
            elsif choice == "q"
                return
            else
                puts "Error message: Select rock, paper, scissors, lizard, or Spock. Input is case senstive."
                puts
                display
            end
        end
    end

    def name_to_number(name)
        # convert name to number using if/elif/else
        case name
            when "rock"
                number = 0
            when "Spock"
                number = 1
            when "paper"
                number = 2
            when "lizard"
                number = 3
            when "scissors"
                number = 4
        end
        return number
    end

    def number_to_name(number)
        # convert number to a name using if/elif/else
        if number == 0
            name = "rock"
        elsif number == 1
            name = "Spock"
        elsif number == 2
            name = "paper"
        elsif number == 3
            name = "lizard"
        elsif number == 4
            name = "scissors"
        else
            return "Error msg: Number in not the correct range between 0 and 4. "
        end
        return name
    end

    def rpsls(player_choice)

        # print out the message for the player's choice
        puts
        puts "Player chooses #{player_choice}. "

        # convert the player's choice to player_number using the function name_to_number()
        player_number = name_to_number(player_choice)

        # compute random guess for comp_number using random.randrange()

        comp_number = rand(0..4)

        # convert comp_number to comp_choice using the function number_to_name()
        comp_choice = number_to_name(comp_number)

        # print out the message for computer's choice
        puts "Computer chooses #{comp_choice}. "
        puts

        # compute difference of comp_number and player_number modulo five
        difference = (comp_number - player_number) % 5
        # use if/elif/else to determine winner, print winner message
        if (difference == 1 or difference == 2)
            winner = "Computer wins!"
        elsif (difference == 3 or difference == 4)
            winner = "Player wins!"
        elsif difference == 0
            winner = "Player and computer tie!"
        else
            return "Error: winner can not be determined"
        end
        print winner
        puts
        puts
    end
end        # End of Spock class