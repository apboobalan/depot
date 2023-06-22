class StoreController < ApplicationController
  include VisitCounter
  before_action :increment_visits, only: [:index]
  def index
    @products = Product.order(:title)
  end
end
