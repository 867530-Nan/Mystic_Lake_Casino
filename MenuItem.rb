# @author Brennick Langston
# @version 1.0.0

require_relative 'Entree'
require_relative 'SideDish'

# Container for individual the menu items
class MenuItem
  include Display

  attr_accessor :name, :entree, :side_dishes

  # Class initializer
  # @param name [String] name of the menu item
  # @param entree [Entree] the entree used to initialize with
  # @return nil
  def initialize(name = nil, entree = nil)
    @side_dishes = []
    @name = name
    @entree = entree
    @pastel = Pastel.new
  end

  def cost
    @entree.price + cost_of_side_dishes
  end

  def cost_of_side_dishes
    sum = 0
    @side_dishes.each { |side_dish| sum += side_dish.price }
    sum
  end

  def side_dishes_string(tabs = 4)
    @side_dishes.each_with_index do |side_dish, index|
      print @pastel.yellow(format("%#{tabs}s%d\.\s%s\n",
        ' ', index + 1, side_dish))
    end
  end

  def menu_item_string
    print @pastel.red(format("%s\n", @name))
    print @pastel.green(format("%2s\>\s%s\n", ' ', @entree))
    side_dishes_string
  end

  def display_side_dishes
    clear_screen
    puts @pastel.green(surround_with_brackets('Side Dishes'))
    @side_dishes.each_index do |index|
      side = format("%4s-\s%d\.\s%s\n", ' ', index + 1, side_dishes[index])
      print @pastel.yellow(side)
    end
  end

  def remove_selected_side_dishes
    prompt = TTY::Prompt.new(help_color: :cyan, active_color: :green)
    answer = prompt.multi_select('Select Side Dishes:',
      @side_dishes, echo: false)
    answer.each do |ans|
      @side_dishes.delete_if { |item| item == ans }
    end
  end

  def add_selected_side_dishes(available_side_dishes)
    prompt = TTY::Prompt.new
    answer = prompt.multi_select('Select Side Dishes:',
      available_side_dishes, echo: false)
    @side_dishes << answer
  end

  def initialize_clone(source)
    super
    @entree = source.entree.clone
    @side_dishes = source.side_dishes.map(&:clone)
  end
end
