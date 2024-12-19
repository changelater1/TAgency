# require 'rails_helper'

# RSpec.describe User, type: :model do

#   context 'associations' do
#     it {should have_many(:owned_orders)}
#     it {should have_many(:given_orders)}
#   end

#   context 'callbacks' do
#     it 'email sending' do
#       message_delivery = instance_double(ActionMailer::MessageDelivery)
#       expect(UserMailer).to receive(:welcome_message).and_return(message_delivery)
#       allow(UserMailer).to receive(:welcome_message).and_return(message_delivery)
#       allow(message_delivery).to receive(:deliver_later)
#       create(:user)
#     end
#   end


#   #has_many :owned_orders, class_name: "Order", foreign_key: :customer_id 
#   #has_many :given_orders, class_name: "Order", foreign_key: :performer_id 
#   #after_create_commit :send_email
# end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:owned_orders).class_name('Order').with_foreign_key(:customer_id) }
    it { should have_many(:given_orders).class_name('Order').with_foreign_key(:performer_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should allow_value("email@example.com").for(:email) }
    it { should_not allow_value("email").for(:email) }
    
    # Password validations can be tested if needed
    # it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(user: 0, translator: 1, admin: 2) }
  end

  describe 'callbacks' do
    it 'sends a welcome email after creation' do
      user = build(:user) # Assuming you have FactoryBot set up
      expect(UserMailer).to receive(:welcome_message).with(user).and_call_original
      user.save
    end
  end

  

  describe '.from_omniauth' do
    let(:access_token) { double(info: { 'email' => 'test@example.com', 'name' => 'Test User' }) }

    context 'when user exists' do
      it 'returns the user' do
        user = create(:user, email: 'test@example.com')
        expect(User.from_omniauth(access_token)).to eq user
      end
    end

    context 'when user does not exist' do
      it 'creates a new user' do
        expect {
          User.from_omniauth(access_token)
        }.to change(User, :count).by(1)
      end
    end
  end
end
