class OrdersController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)
    
    unless user
      user = User.new(name: params[:name], email: params[:email])
      if user.save
        NotificationMailer.welcome_email(user).deliver_now
      end
    end

    order = Order.new(
      user_id: user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      total_price: Product.find(params[:product_id]).price * params[:quantity].to_i
    )

    if order.save
      NotificationMailer.order_confirmation(order).deliver_now
      render json: { message: "Order placed successfully" }, status: :created
    else
      render json: { error: order.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
