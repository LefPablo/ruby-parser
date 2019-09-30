require 'csv'

class ProductToCsv
	
  def initialize file_name 
    @file_name = file_name
  end
  
  def check_file_name 
    if @file_name.slice(/.csv/).nil?
      @file_name += ".csv"
    end
  end

  def write_to_csv products
  	check_file_name
    CSV.open(@file_name, 'w', write_headers: true) do |csv|
	  products.flatten.each do |product|
		csv << product.values
	  end
	end
    puts "The data was writed into #{@file_name}"
  end

end