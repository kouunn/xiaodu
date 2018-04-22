require 'open-uri'
require 'net/http'
require 'open_uri_redirections'

class NokogiriController < ApplicationController
  def index
  	@key_word = params[:search]

  	baidu_url = URI.escape("http://www.baidu.com/s?wd=#{@key_word}")#URI.escape("http://www.baidu.com/s?wd=#{@key_word}")
  	doc= Nokogiri::HTML(open(baidu_url))
  	decode_url = URI.escape("http://www.baidu.com/link?url=5FEJyFnthNeUOZD98UrIzN7O0qZWtc5UknDg5Fk4OrJbongkbcQsLm8Q94reMM65UPqHhXevCv5tSDiWKXXzpa&wd=&eqid=c920619900032cf5000000065adc6bb6")
  	
    @result=doc

  	
    @results = []#Hash.new
    doc.css('.result h3 a').each_with_index do |item,index|
      url=URI.extract(item.to_html).first

      @results[index] = {
        :title => item.at_css(".t"),
        :url => url,
        :true_url => get_real_url(url)
      }
    end

  	baidu_url = URI.escape('https://www.baidu.com/s?wd=#{@key_word}')
  	@result = Nokogiri::HTML(open(baidu_url))
  	

  end

  def search_result

  end

  def get_real_url(url)
    #input_url = URI.escape(url)
    url+="&wd=&eqid=c88708b700042854000000065adc78de"
    response = open(url,:allow_redirections => :safe).read
    tmp_url =URI.extract(response)
    tmp_url.first
  end
end


