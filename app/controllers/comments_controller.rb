class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
  
    if @comment.save
      redirect_to @commentable.is_a?(User) ? profile_path(@commentable) : @commentable, notice: 'Comment added successfully.'
    else
      redirect_to @commentable.is_a?(User) ? profile_path(@commentable) : @commentable, alert: 'Failed to add comment.'
    end
  end

  private

  def set_commentable
    params[:user_id] ||= params[:profile_id]
    klass = [User, Order].find { |c| params["#{c.name.underscore}_id"].present? }
    if klass
      @commentable = klass.find(params["#{klass.name.underscore}_id"])
    else
      raise ActiveRecord::RecordNotFound, "No valid commentable resource found"
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
