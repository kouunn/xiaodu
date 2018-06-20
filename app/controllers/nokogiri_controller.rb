require 'open-uri'
require 'net/http'
require 'json'

class NokogiriController < ApplicationController

  def index
    @page_id = 0
    if params[:search] != nil
      @key_word = URI.encode(params[:search].to_s)
      get_baidu_json
    end
  end

  def next_page
    @page_id+=10
    get_baidu_json
  end

  def get_baidu_json
      
      
      baidu_json = URI.parse("http://www.baidu.com/s?wd=#{@key_word}&pn=#{@page_id}&rn=5&tn=json")
      json = Net::HTTP.get(baidu_json)
      result = JSON.parse(json)
      @results = []
      result["feed"]["entry"].each_with_index do |item,index|
        @results[index] = {
          :title => item["title"],
          :url => item["url"],
          :abs => item["abs"]
        }
        break if index == 4
      end

  end

end


