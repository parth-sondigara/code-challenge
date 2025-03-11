class NotificationMailer < ApplicationMailer
  default from: "no-reply@example.com"  # Change to your email

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Our Store!")
  end

  def order_confirmation(order)
    @order = order
    @user = order.user
    @product = order.product
    mail(to: @user.email, subject: "Order Confirmation ##{@order.id}")
  end
end
