require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    follow_redirect!

    assert_select 'h2', 'Your Cart'
    assert_select 'td', 'Programming Ruby 1.9'
  end

  test "should create line_item with price so that the product price change does not affect" do
    product = products(:ruby)
    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: product.id }
    end

    follow_redirect!

    old_price = product.price
    product.price += 1
    product.save!

    assert LineItem.last.price == old_price, "line item price changed."

    assert_select 'h2', 'Your Cart'
    assert_select 'td', 'Programming Ruby 1.9'
  end

  test "should create line_item via ajax" do
    assert_difference('LineItem.count') do
      post line_items_url, params: {product_id: products(:ruby).id}, xhr: true
    end

    puts @response.body

    assert_response :success
    assert_match /<tr class=\\"line-item-highlight/, @response.body
  end

  test "should return appropriate quantity when adding unique and duplicate products" do
    2.times {post line_items_url, params: { product_id: products(:ruby).id }}
    post line_items_url, params: { product_id: products(:one).id }

    cart = Cart.find(session[:cart_id])

    assert cart.line_items.where(product_id: products(:ruby).id).first.quantity == 2
    assert cart.line_items.where(product_id: products(:one).id).first.quantity == 1

  end

  test "should reset visit counter after adding a line item" do
    5.times do
      get store_index_url
      assert_select '.visits', false
    end

    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    5.times do
      get store_index_url
      assert_select '.visits', false
    end

    get store_index_url
    assert_select '.visits', '6 visits'
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product_id } }
    assert_redirected_to line_item_url(@line_item)
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to cart_url(Cart.find(session[:cart_id]))
  end
end
