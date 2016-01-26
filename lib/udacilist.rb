class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
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
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
