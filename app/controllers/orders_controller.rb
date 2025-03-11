class OrdersController < ApplicationController
  before_action :find_or_create_user, only: :create

  def create
    order = @user.orders.new(order_params)

    if order.save
      render_success("Order placed successfully", OrderSerializer.new(order).serializable_hash, :created)
    else
      render_error("Order creation failed", order.errors.full_messages, :unprocessable_entity)
    end
  end

  private

  def find_or_create_user
    @user = User.find_or_create_by(email: user_params[:email]) do |usr|
      usr.name = user_params[:name]
    end

    render_error("User creation failed", @user.errors, :unprocessable_entity) if @user.errors.any?
  end

  def order_params
    product = Product.find(params[:product_id])
    total_price = product.price * params[:quantity].to_i
    params.permit(:product_id, :quantity).merge(total_price: total_price)
  end

  def user_params
    params.permit(:email, :name)
  end
end
