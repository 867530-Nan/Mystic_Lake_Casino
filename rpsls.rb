# Rock-paper-scissors-lizard-Spock template


# The key idea of this program is to equate the strings
# "rock", "paper", "scissors", "lizard", "Spock" to numbers
# as follows:
#
# 0 - rock
# 1 - Spock
# 2 - paper
# 3 - lizard
# 4 - scissors

# helper functions

# Operator Menu
def display
    puts "********************************************************"
    puts "*                                                      *"
    puts "*                                                      *"       
    puts "*      WELCOME TO THE GAME:                            *"   
    puts "*                                                      *"
    puts "*      rock, paper, scissors, lizard, Spock!           *"
    puts "*                                                      *"
    puts "*      Please select one of the above choices          *"
    puts "*      as listed above:                                *"
    puts "*                                                      *"
    puts "*                                                      *"       
    puts "*                                                      *"
    puts "********************************************************"   
    @game_choice= gets.chomp
end 

def name_to_number(name)
    # delete the following pass statement and fill in your code below
    # convert name to number using if/elif/else
    if name == "rock"
         number = 0
    elsif name == "Spock"
          number = 1
    elsif name == "paper"
          number = 2
    elsif name == "lizard"
          number = 3
    elsif name == "scissors"
          number = 4
    else 
        return "Error msg: Select rock, paper, scissors, lizard, or Spock. Input is case senstive."
    end
    return number
end

def number_to_name(number)
    # delete the following pass statement and fill in your code below
  
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
    # print a blank line to separate consecutive games
    print ("\n")
    
    # print out the message for the player's choice
    print "Player chooses #{player_choice}. "

    # convert the player's choice to player_number using the function name_to_number()
    player_number = name_to_number(player_choice)

    # compute random guess for comp_number using random.randrange()
    
    comp_number = rand(0..4)

    # convert comp_number to comp_choice using the function number_to_name()
    comp_choice = number_to_name(comp_number)
    
    # print out the message for computer's choice
    print " Computer chooses #{comp_choice}. "

    # compute difference of comp_number and player_number modulo five
    difference = (comp_number - player_number) % 5
    # use if/elif/else to determine winner, print winner message
    if (@difference == 1 or @difference == 2)
        winner = " Computer wins!"
    elsif (difference == 3 or difference == 4)
        winner = " Player wins!"
    elsif difference == 0
        winner = " Player and computer tie!"
    else 
        return "Error: winner can not be determined"
    end    
    puts winner
    puts
end


display
rpsls(@game_choice)

=begin  

rpsls("rock")
rpsls("Spock")
rpsls("paper")
rpsls("lizard")
rpsls("scissors")
=end


