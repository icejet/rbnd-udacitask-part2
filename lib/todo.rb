class TodoItem < Item
  include Listable
  attr_reader :due, :priority

  def initialize(description, options = {})
    type = "todo"
    super(description, type)
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    if @priority
      unless ['low', 'medium', 'high', '', ' '].include?(@priority)
        raise UdaciListErrors::InvalidPriorityValue, "#{@priority} isn't valid"
      end
    end
  end

  def details
    row = []
    row << format_description(@description)
    row << "due: " + format_date(:single_date, date: @due) + format_priority(@priority)
  end
end
