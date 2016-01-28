class UdaciList
  attr_reader :title, :items

  def initialize(options = {})
    @title = "Untitled List"
    @title = options[:title] if options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    case type
    when "todo" then @items.push TodoItem.new(description, options)
    when "event" then @items.push EventItem.new(description, options)
    when "link" then @items.push LinkItem.new(description, options)
    else raise UdaciListErrors::InvalidItemType, "#{type} isn't recognized"
    end
  end

  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize, "That index doesn't exist" if index > @items.size
    @items.delete_at(index - 1)
  end

  def all
    a = Artii::Base.new(font: 'nancyj-underlined')
    puts a.asciify(@title)
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
    puts "\n"
  end

  def filter(type)
    filtered_list = @items.select { |item| item.type == type }
    puts "No '#{type}' items found" unless filtered_list.size > 0
    puts filtered_list
  end
end
