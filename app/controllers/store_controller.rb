class StoreController < ApplicationController
  include CurrentCart
  include VisitCounter

  before_action :set_cart
  before_action :increment_visits, only: [:index]
  def index
    @products = Product.order(:title)
  end
end
