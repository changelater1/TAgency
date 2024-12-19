class OrdersController < ApplicationController
  def index
    if current_user.translator?
      @orders = Order.active
    else
      @orders = Order.all
    end
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

  def accept
    order = Order.find(params[:id])
    if current_user.translator? && order.may_start?
      order.start!
      current_user.given_orders << order
      redirect_to order, notice: 'You have accepted the order'
    else
      redirect_to orders_path, alert: 'You can not accept this order.'
    end
  end

  def complete
    @order = current_user.given_orders.find(params[:id])
    
    if @order.update(order_params)
      @order.complete!
      redirect_to owned_orders_profiles_path, notice: 'Order completed successfully!'
    else
      redirect_to owned_orders_profiles_path, alert: 'Failed to complete the order.'
    end
  end

  def select_performer
    @order = Order.find(params[:id])
    @responded_translators = @order.responded_translators
  
    unless current_user == @order.customer
      redirect_to orders_path, alert: 'You are not authorized to select a performer for this order.'
    end
  end
  
  def assign_performer
    @order = Order.find(params[:id])
    translator = User.find(params[:translator_id])
  
    if @order.customer == current_user && @order.responded_translators.include?(translator)
      @order.update(performer: translator)
      @order.start! # Transfer order status to "in_progress"
      redirect_to @order, notice: 'Performer has been assigned successfully.'
    else
      redirect_to orders_path, alert: 'You cannot assign this performer.'
    end
  end

  private

  def order_params
    params.require(:order).permit(:title, :description, :deadline, :file, :completed_file)
  end

  def authorize_admin
    unless current_user.admin?
      flash[:alert] = "Access denied. Only admins can view orders."
      redirect_to root_path
    end
  end
end