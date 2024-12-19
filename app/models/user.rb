class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2], authentication_keys: [:email]

  has_many :owned_orders, class_name: "Order", foreign_key: :customer_id 
  has_many :given_orders, class_name: "Order", foreign_key: :performer_id 
  # Respond model dependencies
  has_many :responses, dependent: :destroy
  has_many :responded_orders, through: :responses, source: :order
  # Comment model dependencies
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :authored_comments, class_name: 'Comment', foreign_key: 'user_id', dependent: :destroy # reviews that user left
  
    
  after_create_commit :send_email

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
     unless user
         user = User.create(name: data['name'],
            email: data['email'],
            password: Devise.friendly_token[0,20],
            confirmed_at: Time.now
            
         )
         user.skip_confirmation!
     end
    user
end

  enum role: {user: 0, translator: 1, admin: 2 }

  private

  def send_email
    UserMailer.welcome_message(self).deliver_later
  end
end
