class OrdersController < ApplicationController
  before_action :authorize_admin, only: [:index]
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = current_user.owned_orders.new
  end

  def create
    @order = current_user.owned_orders.active.new(order_params)
    if @order.save
      redirect_to my_profile_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:title, :description, :deadline, :file)
  end

  def authorize_admin
    unless current_user.admin?
      flash[:alert] = "Access denied. Only admins can view orders."
      redirect_to root_path
    end
  end
end