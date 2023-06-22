require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select 'nav.side_nav a', minimum: 4
    assert_select 'main ul.catalog li', 3
    assert_select 'h2', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test "should show visits counter after 6 visits" do
    5.times do
      get store_index_url
      assert_select '.visits', false
    end

    get store_index_url
    assert_select '.visits', '6 visits'
  end

end
