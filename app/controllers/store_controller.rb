class StoreController < ApplicationController
  include VisitCounter
  def index
    @products = Product.order(:title)
    @visits = increment_and_get_visits
  end
end
