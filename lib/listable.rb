module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(type, options = {})
    if type == :single_date
      return options[:date] ? options[:date].strftime("%D") : "No due date"
    end
    if type == :dual_dates
      dates = options[:start_date].strftime("%D") if options[:start_date]
      dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
      dates = "N/A" if !dates
      return dates
    end
  end

  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:yellow) if priority == "medium"
    value = " ⇩".colorize(:green) if priority == "low"
    value = "" if !priority
    return value
  end
end
