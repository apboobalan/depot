class AddPriceToLineItems < ActiveRecord::Migration[6.0]
  def up
    add_column :line_items, :price, :decimal, precision: 8, scale: 2, default: 0.0
    copy_price_from_product
  end

  def down
    remove_column :line_items, :price
  end

  private

  def copy_price_from_product
    LineItem.all.each do |line_item|
      line_item.price = line_item.product.price
      line_item.save!
    end
  end
end
