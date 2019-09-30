require 'nokogiri'
require 'curb'

module Reader
  def Reader.html_reader url
	html = Nokogiri::HTML(Curl.get(url).body_str)
  end

  def Reader.get_info_by_xpath(html, path)
	html.xpath(path)
  end
end