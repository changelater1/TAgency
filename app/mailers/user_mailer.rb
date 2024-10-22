class UserMailer < ApplicationMailer
  def welcome_message(user)
      @greeting = "Hi"
      mail to: user.email, subject: 'Account registration'
  end
end
