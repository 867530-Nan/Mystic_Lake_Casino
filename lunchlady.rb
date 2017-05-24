# @author Brennick Langston
# @version 1.0.0
# @todo Add Drinks

require 'pry'
require 'tty'

require_relative 'Menu'
require_relative 'Tab'
require_relative 'Display'

class LunchLady
  include Display

  def initialize
    @prompt = TTY::Prompt.new
    @pastel = Pastel.new
    init_static_objects
    show_app_menu
  end

  def show_app_menu
    title = surround_with_brackets('Lunch Lady Menu')
    options = [
      '1. Create Menu Item',
      '2. Change Menu',
      '3. View Menu',
      '4. Place an Order',
      '5. Change Order',
      '6. Delete Order',
      '7. View Order',
      '8. View Bill',
      '9. Set Wallet',
      '10. Quit'
    ]
    clear_screen
    @prompt.say(@pastel.green(title))
    options.each { |opt| @prompt.say(@pastel.yellow(opt)) }
    answer = ask_for_menu_selection(options.count)
    process_app_menu_option(answer)
  end

  def ask_for_menu_selection(num_opts)
    question = "Enter options: (1-#{num_opts})"
    answer = @prompt.ask(@pastel.red(question), convert: :int) do |q|
      q.in("1-#{num_opts}")
      q.messages[:range?] = '%{value} out of expected range %{in}'
    end
    answer
  end

  def process_app_menu_option(option)
    case option
    when 1
      create_menu_items
    when 2
      change_menu_items
    when 3
      view_menu_items
    when 4
      place_an_order
    when 5
      change_order
    when 6
      delete_order
    when 7
      view_order
    when 8
      view_final_bill
    when 9
      set_wallet_amount
    when 10
      exit_application
    else
      view_input_error(option)
    end
  end

  def exit_application
    clear_screen
    @prompt.say(@pastel.green('Exiting Application'))
    spacer(5)
    sleep(0.4) 
  end

  def view_input_error(option)
    clear_screen
    message = "Invalid Input value <#{option}> Please try again."
    @prompt.say(@pastel.red(message))
    spacer(5)
    sleep(0.4)
    show_app_menu
  end

  def change_side_dishes_ordered
    @tab.display_current_order
    menu_item = @tab.select_menu_item
    @tab.remove_side_dishes(menu_item)
    display_available_side_dishes
    menu_item.side_dishes << select_side_dishes.clone
    # side_dishes = select_side_dishes
    # @tab.add_side_dishes_to_menu_item(menu_item,side_dishes)
  end

  def create_menu_items
    clear_screen
    title = @prompt.ask('What is the Item\'s Title?') do |q|
      q.required(true)
      q.validate(/[a-zA-Z]+/)
      q.modify(:capitalize)
    end
    entree = select_an_entree
    sides = select_a_side_dish
    menu_item = @main_menu.new_menu_item
    menu_item.name = title
    menu_item.entree = @available_entrees[entree - 1]
    sides.each { |side| menu_item.side_dishes << @available_side_dishes[side - 1] }
    view_menu_items
  end

  def select_an_entree
    choices = {}
    @available_entrees.each_index do |index|
      choices[@available_entrees[index].name] = index + 1
    end
    entree = @prompt.select('What Entree is included?', choices)
    entree
  end

  def select_a_side_dish
    sides_question = 'What Side Dishes are included?'
    side_dishes = {}
    # @todo use map and hash
    @available_side_dishes.each_index do |index|
      side_dishes[@available_side_dishes[index].name] = index + 1
    end
    sides = @prompt.multi_select(sides_question, side_dishes, per_page: 10)
    sides
  end

  def change_menu_items
    clear_screen
    choices = @main_menu.menu_items.map.with_index { |mi,i| [mi.name,i] }.to_h
    menu_item = @prompt.select('Select Menu Item to Change:', choices)
    which = {"Entree" => 1, "Side Dish" => 2}
    answer = @prompt.select('What would you like to change?', which)
    selected_menu_item = @main_menu.menu_items[menu_item]
    answer == 1 ? change_entree(selected_menu_item) : change_side_dishes(selected_menu_item)
  end

  def change_entree(menu_item, clone = false)
    entree = select_an_entree
    if clone
      menu_item.entree = @available_entrees[entree - 1].clone
    else
      menu_item.entree = @available_entrees[entree - 1]
    end
    bool = @prompt.yes?('Do you want to change the side dishes?')
    bool ? change_side_dishes(menu_item, clone) : show_app_menu
  end

  def change_side_dishes(menu_item, clone = false)
    sides = select_a_side_dish
    menu_item.side_dishes.clear
    sides.each do |side|
      if clone
        menu_item.side_dishes << @available_side_dishes[side - 1].clone
      else
        menu_item.side_dishes << @available_side_dishes[side - 1]
      end
    end
    bool = @prompt.yes?('Do you want to change the entree?')
    bool ? change_entree(menu_item, clone) : show_app_menu
  end

  def view_order
    clear_screen
    list_ordered_items
    @prompt.ask(@pastel.red("Press the \"Enter\" key to continue.."))
  end

  def list_ordered_items
    clear_screen
    @prompt.say(surround_with_brackets('Current Order'))
    @tab.menu_items.each do |menu_item|
      menu_name = format('%2s%-43s', ' ', menu_item.name)
      puts @pastel.red(menu_name)
      entree = format("%4s>\s%-39s", ' ', menu_item.entree)
      puts @pastel.green(entree)
      menu_item.side_dishes.each do |side|
        sd = format("%6s\-\s%-37s", ' ', side)
        puts @pastel.yellow(sd)
      end
    end
  end

  def place_an_order
    @main_menu.display_menu
    choices = @main_menu.menu_items.map.with_index { |mi,i| [mi.name,i] }.to_h
    selection = @prompt.select("Select Menu Items", choices)
    @tab.menu_items << @main_menu.menu_items[selection].clone
    bool = @prompt.yes?('Modify Ordered Item')
    if bool
      change_order
    else
      bool = @prompt.yes?('Add Another Item?')
      bool ? place_an_order : view_order
    end
    show_app_menu
  end

  def change_order
    list_ordered_items
    choices = @tab.menu_items.map.with_index { |mi,i| [mi.name,i] }.to_h
    selection = @prompt.select("Select Menu Items", choices)
    changes = {
      'Delete Menu Item?' => 1,
      'Change Entree?' => 2,
      'Change Side Dishes' => 3,
      'Back to Main Menu' => 4
    }
    change = @prompt.select('Select Desired Change?', changes)
    if change == 1
      delete_tab_item(@tab.menu_items[selection])
    elsif change == 2
      change_entree(@tab.menu_items[selection], true)
    elsif change == 3
      change_side_dishes(@tab.menu_items[selection], true)
    else
      show_app_menu
    end
    show_app_menu
  end

  def delete_order
    @tab.menu_items.clear
    show_app_menu
  end

  def delete_tab_item(menu_item)
    @tab.menu_items.delete_if { |item| item == menu_item }
    show_app_menu
  end

  def view_final_bill
    clear_screen
    list_ordered_items
    lined_separator
    sub_total = format("%15s\:\s%5.2f", 'Sub Total', @tab.sub_total_cost)
    @prompt.say(@pastel.red(sub_total))
    tax_cost = format("%15s\:\s%5.2f", 'Tax', @tab.tax_cost)
    @prompt.say(@pastel.red(tax_cost))
    tip_cost = format("%15s\:\s%5.2f", 'Gratuity', @tab.tip_cost)
    @prompt.say(@pastel.red(tip_cost))
    total_cost = format("%15s\:\s%5.2f", 'Total', @tab.total_cost)
    @prompt.say(@pastel.red(total_cost))
    display_wallet_status
    @prompt.ask(@pastel.yellow('Press [Enter] key to continue..'))
    show_app_menu
  end

  def display_wallet_status
    status = @tab.wallet_status
    wallet = format("%15s\:\s%5.2f", 'Wallet', @tab.wallet_status)
    if status > 0
      @prompt.say(@pastel.green(wallet))
    elsif status < 0
      @prompt.say(@pastel.red(wallet))
    elsif status.zero?
      @prompt.say(format("%15s\:\s%s", 'No Wallet', '--.--'))
    end
  end

  def set_wallet_amount
    clear_screen
    wallet = @prompt.ask('Set wallet amount to?', convert: :float)
    @tab.wallet(wallet) unless wallet.nil?
    show_app_menu
  end

  def select_side_dishes
    count = @available_side_dishes.count
    question = "Select Side Dishes: (1-#{count}) [comma seperated list]"
    answer = @prompt.ask(@pastel.green(question), convert: :int) do |q|
      q.convert -> (input) { input.split(',\s*') }
      q.in("1-#{count}")
      q.messages[:range?] = '%{value} out of expected range #{in}'
    end
    answer
  end

  def display_available_side_dishes
    title = format("%s\s%s\s%s", '-' * 5, 'Available Side Dishes', '-' * 5)
    @prompt.say(@pastel.green(title))
    @available_side_dishes.each_index do |index|
      item = "#{index + 1}.)\s#{@available_side_dishes[index]}"
      @prompt.say(@pastel.yellow(item))
    end
  end

  def remove_side_dish(item_num)
    menu_item = @main_menu.menu_items[item_num]
    menu_item.display_side_dishes
    menu_item.remove_selected_side_dishes
  end

  def add_side_dish(item_num)
    menu_item = @main_menu.menu_items[item_num]
    menu_item.display_side_dishes
    menu_item.add_selected_side_dishes(@available_side_dishes)
  end

  def remove_menu_item(delete_item)
    @main_menu.menu_items.delete_if { |item| item == delete_item }
  end

  def view_menu_items
    @main_menu.display_menu
    @prompt.ask(@pastel.red("Press the \"Enter\" key to continue.."))
    show_app_menu
  end

  def init_static_objects
    prompt = TTY::Prompt.new
    progress = TTY::ProgressBar.new('Initializing System [:bar]', total: 100)
    pastel = Pastel.new
    clear_screen
    prompt.say(pastel.green('Welcome to Lunch Lady'))
    prompt.say("\n\n\n")
    progress.advance(10)
    sleep(0.1)

    # Creating the side dishes that can be used with each menu items
    mashed_potatoes = SideDish.new('Mashed Potatoes', 2.00)
    sweet_corn = SideDish.new('Nebraska Sweet Corn', 1.50)
    carrots = SideDish.new('Baby Carmelized Carrots', 1.75)
    fried_pickles = SideDish.new('Carolina Fried Pickles', 2.00)
    butter_spinach = SideDish.new('Buttered Spinach', 0.50)
    sweet_potatoes = SideDish.new('Sweet Potatoes', 1.25)
    coleslaw = SideDish.new('House Coleslaw', 1.00)

    @available_side_dishes = [
      mashed_potatoes,
      sweet_corn,
      carrots,
      fried_pickles,
      butter_spinach,
      sweet_potatoes,
      coleslaw
    ]

    progress.advance(10)
    sleep(0.1)

    # Creating the Entree dishes
    corned_beef = Entree.new('Corned Beef', 3.50)
    meatloaf = Entree.new('MeatLoaf', 5.00)
    mystery_meat = Entree.new('Mystery Meat Suprise', 3.00)
    slop = Entree.new('Pig Slop', 1.00)
    fried_chicken = Entree.new('Frid Chicken', 4.50)

    @available_entrees = [
      corned_beef,
      meatloaf,
      mystery_meat,
      slop,
      fried_chicken
    ]

    progress.advance(10)
    sleep(0.1)

    # Creating Menu Items that can be purchased
    hawaiian = MenuItem.new('Hawaiian Spice', corned_beef)
    hawaiian.side_dishes << sweet_potatoes
    hawaiian.side_dishes << butter_spinach
    hawaiian.side_dishes << fried_pickles

    progress.advance(10)
    sleep(0.1)

    down_south = MenuItem.new('Southern Chicken', fried_chicken)
    down_south.side_dishes << coleslaw
    down_south.side_dishes << sweet_corn
    down_south.side_dishes << mashed_potatoes

    progress.advance(10)
    sleep(0.1)

    zion = MenuItem.new('Zion\'s Cuisine', mystery_meat)
    zion.side_dishes << fried_pickles
    zion.side_dishes << carrots
    zion.side_dishes << butter_spinach

    progress.advance(10)
    sleep(0.1)

    alabama = MenuItem.new('Alabama\'s Best Meatloaf', meatloaf)
    alabama.side_dishes << coleslaw
    alabama.side_dishes << sweet_potatoes
    alabama.side_dishes << butter_spinach

    progress.advance(10)
    sleep(0.1)

    texas = MenuItem.new('Texas Sweet Slop', slop)
    texas.side_dishes << mashed_potatoes
    texas.side_dishes << sweet_corn
    texas.side_dishes << carrots

    progress.advance(10)
    sleep(0.1)

    # create the main menu for the lunch Lady app
    @main_menu = Menu.new('Lunch Lady Menu')

    # Fill the Menu with Menu Items that are available for purchase
    @main_menu.menu_items << texas
    @main_menu.menu_items << alabama
    @main_menu.menu_items << zion
    @main_menu.menu_items << down_south
    @main_menu.menu_items << hawaiian

    progress.advance(20)
    sleep(0.1)

    # Create a Tab for holding the programs orders
    @tab = Tab.new(0.15,0.075)
  end
end

# LunchLady.new

# Testing area
# @tab.add_ordered_item(texas)
# @tab.add_ordered_item(alabama)
# @tab.add_ordered_item(zion)
#
# change_side_dishes_ordered
