module Display
  def clear_screen
    puts "\e[2J"
  end

  def surround_with_brackets(text)
    '-' * 5 + "\s#{text}\s" + '-' * 5
  end

  def spacer(spaces = nil)
    print spaces.nil? ? "\n" : "\n" * spaces
  end

  def lined_separator(width = 30)
    puts format("%#{width}s", '-'*width)
  end
end
