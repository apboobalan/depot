require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'add custom message for empty attributes' do
    product = Product.new
    assert product.invalid?
    assert_equal ['must be present'], product.errors[:description]
  end

  test 'product price must be positive' do
    product = Product.new(title: 'My Book Title',
                          description: 'yyy',
                          image_url: 'zzz.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: 'My Book 01',
                description: 'yyy',
                price: 1,
                image_url: image_url)
  end

  test 'must be a URL for GIF, JPG or PNG image.' do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
    bad = %w{fred.doc fred.gif/more fred.gif.more}

    bad.each do |image_url|
      product = new_product image_url
      assert product.invalid?, "#{image_url} shouldn't be valid"
    end

    ok.each do |image_url|
      product = new_product image_url
      assert product.valid?, "#{image_url} should be valid"
    end
  end

  test 'product is not valid without a unique title' do
    product =  Product.new(title: products(:ruby).title,
                           description: 'yyy',
                           price: 1,
                           image_url: 'fred.gif')

    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  test 'product title should be at least 10 characters long' do
    product = Product.new(description: 'yyy',
                          price: 1,
                          image_url: 'fred.gif')

    product.title = "123"
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.too_short', count: 10)], product.errors[:title]
  end
end
