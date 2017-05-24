# @author Brennick Langston
# @version 1.0.0

require_relative 'Display'
require_relative 'MenuItem'

# Class for handling the menu items
class Menu
  include Display

  attr_accessor :menu_items

  def initialize(title = nil)
    @title = title
    @menu_items = []
    @pastel = Pastel.new
  end

  def display_menu
    clear_screen
    puts @pastel.red(surround_with_brackets(@title))
    @menu_items.each_index do |index|
      print @pastel.red(format("%d\.\s", index + 1))
      @menu_items[index].menu_item_string
    end
  end

  def select_menu_item
    clear_screen
    prompt = TTY::Prompt.new
    item_count = @menu_items.count
    out_str = @pastel.red("Please select a dish (1-#{item_count})?")
    @selected_item = prompt.ask(out_str, convert: :int) do |q|
      q.in("1-#{item_count}")
    end
  end

  def menu_selection
    @menu_items[@selected_item - 1]
  end

  def new_menu_item
    @menu_items << MenuItem.new
    @menu_items.last
  end

  def order_menu_item
    display_menu
    select_menu_item
    menu_selection
  end
end
