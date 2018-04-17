require 'open-uri'
require 'net/http'
class NokogiriController < ApplicationController
  def index
  	@key_word = params[:search]
  	baidu_url = URI.escape("http://www.baidu.com/s?wd=#{@key_word}")
  	@result = Nokogiri::HTML(open(baidu_url))
  	
  end

  def search_result

  end
end
