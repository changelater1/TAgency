class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  after_create_commit :send_email

  

  enum role: {user: 0, translator: 1, admin: 2 }

  private

  def send_email
    UserMailer.welcome_message(self).deliver_later
  end
end
