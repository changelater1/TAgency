class ProfilesController < ApplicationController
  before_action :set_user, only: [ :update, :show]
  # Отображение профиля конкретного юзера
  def show
  end
  #  Изменение данных профиля определенного юзера
  def edit
    @user = current_user
  end
  #  Обновление данных профиля определенного юзера
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Your profile has been updated successfully"
    else
      render :edit
    end
  end

  def my_profile
    @user = current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :phone_number, :country, :email)
  end
end
