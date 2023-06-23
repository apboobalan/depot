require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  setup do
    @product = products(:ruby)
    @cart = carts(:ruby)
  end
  test "total price of line item is calculated using set price even if product price increases" do
    old_price = @product.price
    @cart.add_product(@product).save!

    @product.price += 1
    @product.save!

    line_item = @cart.line_items.last

    assert_equal line_item.total_price, old_price * line_item.quantity

  end
end
