class NoteItem < Item
  include Listable
  attr_reader :created

  def initialize(description)
    type = "note"
    super(description, type)
    @created = Time.now
  end

  def details
    row = []
    row << format_description(@description)
    row << "created: " + format_date(:single_date, date: @created)
  end
end
