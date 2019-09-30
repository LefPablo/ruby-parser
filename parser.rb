require_relative 'category_parser'

class Parser

  def initialize url, file_name
    @url = url
    @file = file_name
  end

  def start
    CategoryParser.new(@url).parse_page(@file)
  end
end