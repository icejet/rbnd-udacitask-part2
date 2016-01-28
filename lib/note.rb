class NoteItem < Item
  include Listable
  attr_reader :created

  def initialize(description)
    type = "note"
    super(description, type)
    @created = Time.now
  end

  def details
    format_description(@description) + "created: " +
    format_date(:single_date, date: @created)
  end
end
