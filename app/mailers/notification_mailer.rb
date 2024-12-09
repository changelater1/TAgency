class NotificationMailer < ApplicationMailer
  def order_status(order_id)
    @order = Order.find(order_id)
    mail to: @order.customer.email, subject: 'Order status was changed!'
  end
end