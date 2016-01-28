class EventItem < Item
  include Listable
  attr_reader :start_date, :end_date

  def initialize(description, options={})
    type = "event"
    super(description, type)
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
  end

  def details
    format_description(@description) + "event dates: " +
      format_date(:dual_dates, start_date: @start_date, end_date: @end_date)
  end
end
