class CommentsController < ApplicationController
  before_action :authenticate_user!

  def profile_comment
    @user = User.find(params[:profile_id])
    @comment = @user.comments.new(comment_params.merge(user:current_user))
    
  
    if @comment.save
      redirect_to profile_path(@user), notice: 'Comment added successfully.'
    else
      redirect_to profile_path(@user), alert: 'Failed to add comment.'
    end
  end

  def order_comment
    @order = Order.find(params[:order_id])
    @comment = @order.comments.new(comment_params.merge(user:current_user))
  
    if @comment.save
      redirect_to order_path(@order), notice: 'Comment added successfully.'
    else
      redirect_to order_path(@order), alert: 'Failed to add comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
