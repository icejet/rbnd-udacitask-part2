module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(type, options = {})
    return format_single_date(options) if type == :single_date
    return format_dual_dates(options) if type == :dual_dates
  end

  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:yellow) if priority == "medium"
    value = " ⇩".colorize(:green) if priority == "low"
    value = "" if !priority
    return value
  end

  private

  def format_single_date(options = {})
    date_format = "%D %T"
    options[:date] ? options[:date].strftime(date_format) : "No due date"
  end

  def format_dual_dates(options = {})
    date_format = "%D"
    dates = options[:start_date].strftime(date_format) if options[:start_date]
    dates << " -- " + options[:end_date].strftime(date_format) if options[:end_date]
    dates = "N/A" if !dates
    return dates
  end
end
