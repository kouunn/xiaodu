require 'open-uri'
require 'net/http'
require 'open_uri_redirections'

class NokogiriController < ApplicationController
  def index
  	@key_word = params[:search]

    baidu_url = URI.escape("http://www.baidu.com/s?wd=#{@key_word}")
    doc= Nokogiri::HTML(open(baidu_url))
    @result=doc

    @results = []
    doc.css('.result .t').each_with_index do |item,index|
      url=URI.extract(item.to_html).first

      @results[index] = {
        :title => item.at_css("a").content,
        :true_url => get_real_url(item.at_css("a")[:href])
      }
    respond_to do |format|
      format.html
      format.js
    end
    end

  	#baidu_url = URI.escape('https://www.baidu.com/s?wd=#{@key_word}')
  	#@result = Nokogiri::HTML(open(baidu_url))
  	

  end

  def search_result

  end

  def get_real_url(url)
    #input_url = URI.escape(url)
    url+="&wd=&eqid=c88708b700042854000000065adc78de"
    response = open(url,:allow_redirections => :safe).read
    tmp_url =URI.extract(response, ["http", "https"])
    tmp_url.first
  rescue 
    nil
  end

end


