require_relative 'html_raw'

class ProductParser
  include Reader
  
  TITLE_XPATH = "//h1[@class='product_main_name']/text()"
  
  RADIO_LIST_XPATH = "//ul[@class='attribute_radio_list']/li/label"
    IMAGE_XPATH = "//img[@id='bigpic']/@src"
    WEIGHT_XPATH = "./span[@class='radio_label']/text()"
    PRICE_XPATH = "./span[@class='price_comb']/text()"

  def initialize href
    @html = Reader::html_reader(href)
  end

  def get_title
    Reader::get_info_by_xpath(@html, TITLE_XPATH).to_s.strip
  end

  def get_image
    Reader::get_info_by_xpath(@html, IMAGE_XPATH).to_s
  end

  def get_price path
    Reader::get_info_by_xpath(path, PRICE_XPATH).to_s.chomp('€/u').strip
  end

  def get_weight path
    Reader::get_info_by_xpath(path, WEIGHT_XPATH).to_s.chomp('.').strip
  end
  
  def get_radio_list
	Reader::get_info_by_xpath(@html, RADIO_LIST_XPATH)
  end
  
  def title_with_weight title, weight
    product_name = title + " - " + weight
  end
 
  def parse_product  
	title = get_title
	image = get_image
	product_info = []
	get_radio_list.each do |x|
	  weight = get_weight(x)
	  price = get_price(x)
	  full_title = title_with_weight(title, weight)
	  product_info.push(
		title: full_title,
		price: price,
		image: image
	  )
	end
	return product_info
  end
end