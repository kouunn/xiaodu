require 'test_helper'

class NokogiriControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nokogiri_index_url
    assert_response :success
  end

end
