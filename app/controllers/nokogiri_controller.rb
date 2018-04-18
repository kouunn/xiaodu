require 'open-uri'
require 'net/http'
class NokogiriController < ApplicationController
  def index
  	@key_word = params[:search]
  	baidu_url = URI.escape('https://www.baidu.com/s?wd=#{@key_word}')
  	@result = Nokogiri::HTML(open(baidu_url))
  	

	@test_url = open('http://www.baidu.com/link?url=s6Wp04kwZ2XF9pjFbw5TnZqr2b-zAmMpdv-eXiSNtu0Yuo8kkPKnwBO3rNnI7lgE').meta.text
	
  end

  def search_result

  end
end
