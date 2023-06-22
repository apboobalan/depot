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

  test 'should show 1 visit when the user loads index first time' do
    get store_index_url
    assert_response :success

    assert_select '.visits', '1 visit'
  end

  test 'should show 2 visits when the user loads index second time' do
    get store_index_url
    get store_index_url
    assert_response :success

    assert_select '.visits', '2 visits'
  end

end
