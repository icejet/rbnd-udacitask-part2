class UdaciList
  attr_reader :title, :items, :last_deleted

  def initialize(options = {})
    @title = "Untitled List"
    @title = options[:title] if options[:title]
    @items = []
  end

  def add(type, description, options = {})
    type = type.downcase
    case type
    when "todo" then @items.push TodoItem.new(description, options)
    when "event" then @items.push EventItem.new(description, options)
    when "link" then @items.push LinkItem.new(description, options)
    when "note" then @items.push NoteItem.new(description)
    else raise UdaciListErrors::InvalidItemType, "#{type} isn't recognized"
    end
  end

  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize, "That index doesn't exist" if index > @items.size
    @last_deleted = { item: @items.slice!(index - 1), index: index - 1 }
  end

  def undo_last_delete
    @items.insert(@last_deleted[:index], @last_deleted[:item]) if last_deleted
    @last_deleted = nil
  end

  def all
    a = Artii::Base.new(font: 'nancyj-underlined')
    puts a.asciify(@title)
    rows = []
    @items.each_with_index do |item, position|
      # puts "#{position + 1}) #{item.details}"
      row = item.details.insert(0, position + 1)
      rows << row
    end
    table = Terminal::Table.new rows: rows
    puts table
    puts "\n"
  end

  def filter(type)
    filtered_list = @items.select { |item| item.type == type }
    puts "No '#{type}' items found" unless filtered_list.size > 0
    a = Artii::Base.new(font: 'nancyj-underlined')
    puts a.asciify(@title + " - #{type}")
    rows = []
    filtered_list.each_with_index do |item, position|
      row = item.details.insert(0, position + 1)
      rows << row
    end
    table = Terminal::Table.new rows: rows
    puts table
  end
end
