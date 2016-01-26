class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options = {})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    if @priority
      unless ['low', 'medium', 'high', '', ' '].include?(@priority)
        raise UdaciListErrors::InvalidPriorityValue, "#{@priority} isn't valid"
      end
    end
  end

  def details
    format_description(@description) + "due: " +
      format_date(:single_date, due: @due) +
      format_priority(@priority)
  end
end
