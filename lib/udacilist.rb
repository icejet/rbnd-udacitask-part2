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
    print_table(@title, create_row_array(@items))
  end

  def filter(type)
    filtered_list = @items.select { |item| item.type == type }
    puts "No '#{type}' items found" unless filtered_list.size > 0
    header = "#{@title} - #{type}"
    print_table(header, create_row_array(filtered_list))
  end

  private

  def print_table(header, row_array)
    a = Artii::Base.new(font: 'nancyj-underlined')
    puts a.asciify(header)
    table = Terminal::Table.new rows: row_array
    puts table
  end

  def create_row_array(item_array)
    rows = []
    item_array.each_with_index do |item, position|
      row = item.details.insert(0, position + 1)
      rows << row
    end
    rows
  end
end
