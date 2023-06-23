module CurrentCart
  private

  CART_ID = :cart_id

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[CART_ID] = @cart.id
  end

  def session_cart_id
    session[CART_ID]
  end
end