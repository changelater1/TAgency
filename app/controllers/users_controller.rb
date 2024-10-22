class UsersController < ApplicationController
  def create
    @user = User.new(signup_params)
    if @user.save!
      session[:user_id] = @user.id
      UserMailer.with(user: current_user).welcome_msg.deliver_later
      render json: @user, status: :created
    end
   end
end
