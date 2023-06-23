require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  setup do
    @product = products(:ruby)
    @cart = carts(:one)
  end
  test "total price of line item is calculated using set price even if product price increases" do
    old_price = @product.price
    2.times do
      line_item = @cart.add_product(@product)
      line_item.save!
    end

    @product.price += 1
    @product.save!

    assert @product.price != old_price
    assert LineItem.last.total_price == old_price * 2

  end
end
