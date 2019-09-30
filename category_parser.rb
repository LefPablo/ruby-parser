require_relative 'html_raw'
require_relative 'product_to_csv'
require_relative 'product_parser'

class CategoryParser
	include Reader

	PRODUCT_URL_XPATH = "//a[@class='product_img_link product-list-category-img']/@href"
  
	def initialize url
	  @url = url
	  @html = Reader::html_reader(url)
	end

	def product_links
	  links = []
	  param = '?p='
	  suff = ''
	  page = 1
	  loop do
		html = Curl.get(@url + suff).body_str
		doc = Nokogiri::HTML(html)
		break if doc.xpath("//ul[@id='product_list']").to_s == ''
		page += 1
		suff = param + page.to_s
		doc.xpath(PRODUCT_URL_XPATH).each do |a|
			links << a.to_s
		end
	  end
	return links
	end

	def parse_page file_name
	  links = product_links
	  puts "I found #{links.size()} products"
	  puts "Processed item number:"
	  products = []
	  n = 0
	  links.each do |a|
		products << ProductParser.new(a).parse_product
		n +=1
		print "#{n}; " 
	  end
	  puts
	  ProductToCsv.new(file_name).write_to_csv(products)
	end
end