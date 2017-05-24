# @author Brennick Langston
# @version 1.0.0

require_relative 'Display'

# Holds the Meals
class Tab
  include Display

  attr_reader :tip, :tax
  attr_accessor :total, :sub_total, :menu_items

  def initialize(tip = 0.2, tax = 0.07)
    @tip = tip
    @tax = tax
    @menu_items = []
    @wallet = 0.0
  end

  def wallet(amount)
    unless amount.nil?
      @wallet = amount.is_a?(String) ? amount.to_f : amount
    end
    @wallet
  end

  def wallet_status
    total_cost # make sure it is up to date
    @wallet - @total
  end

  def total_cost
    sub_total_cost # Always recalculate the sub_total
    @total = @sub_total + tip_tax_cost
    @total
  end

  def sub_total_cost
    @sub_total = 0.0
    @menu_items.each { |menu_item| @sub_total += menu_item.cost }
    @sub_total
  end

  def tip_tax_cost
    sub_total_cost if @sub_total.nil?
    tip_cost + tax_cost
  end

  def tip_cost
    sub_total_cost if @sub_total.nil?
    @sub_total * @tip
  end

  def tax_cost
    sub_total_cost if @sub_total.nil?
    @sub_total * @tax
  end

  def remove_ordered_item
    display_current_order
    prompt = TTY::Prompt.new
    out_str = "Remove Item (1-#{@menu_items.count})?"
    answer = prompt.ask(out_str, convert: :int) do |q|
      q.in("1-#{@menu_items.count}")
    end
    @menu_items.delete_at(answer - 1)
  end

  def add_ordered_item(item)
    @menu_items << item
  end

  def display_current_order
    clear_screen
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    title = surround_with_brackets('Current Customer Order')
    prompt.say(pastel.red(title))
    @menu_items.each { |item| item.menu_item_string }
  end

  def display_final_order
    clear_screen
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    display_current_order
    prompt.say(pastel.green("SubTotal:\s#{sub_total_cost}"))
    prompt.say(pastel.green("Tax:\s#{tax_cost}"))
    prompt.say(pastel.green("Gratuity:\s#{tip_cost}"))
    prompt.say(pastel.green("Total:\s#{total_cost}"))
  end

  def remove_side_dishes(item_num)
    @menu_items[item_num].display_side_dishes
    @menu_items[item_num].remove_selected_side_dishes
  end

  def add_side_dishes_to_menu_item(menu_item_num, side_dishes)
    @menu_items[menu_item_num].side_dishes << side_dishes.clone
  end

  def select_menu_item
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    display_menu_items
    count = @menu_items.count
    question = "Choose a Menu Item: (1-#{count}):\s"
    answer = prompt.ask(pastel.green(question), convert: :int) do |q|
      q.in("1-#{count}")
      q.messages[:range?] = '%{value} out of expected range #{in}'
    end
    answer
  end

  def display_menu_items
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    title = surround_with_brackets('Ordered Menu Items')
    prompt.say(pastel.green(title))
    @menu_items.each_index do |index|
      menu_item = @menu_items[index].name
      item = "#{index + 1}\s#{menu_item}"
      prompt.say(pastel.yellow(item))
    end
  end

  def initialize_clone(source)
    super
    @menu_items = source.menu_items.map(&:clone)
  end
end
