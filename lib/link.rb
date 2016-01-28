class LinkItem < Item
  include Listable
  attr_reader :site_name

  def initialize(url, options={})
    type = "link"
    super(url, type)
    @site_name = options[:site_name]
  end
  def format_name
    @site_name ? @site_name : ""
  end
  def details
    format_description(@description) + "site name: " + format_name
  end
end
