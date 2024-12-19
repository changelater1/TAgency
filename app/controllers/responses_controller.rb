class ResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_translator!

  def create
    order = Order.find(params[:order_id])
    if order.active? && !order.responses.exists?(user: current_user)
      order.responses.create(user: current_user)
      redirect_to order_path(order), notice: 'You have successfully responded to the order.'
    else
      redirect_to order_path(order), alert: 'You cannot respond to this order.'
    end
  end

  private

  def ensure_translator!
    redirect_to root_path, alert: 'Only translators can respond to orders.' unless current_user.translator?
  end
end
