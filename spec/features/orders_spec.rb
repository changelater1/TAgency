require 'rails_helper'
RSpec.describe Order, driver: :selenium_chrome, js: true, type: :feature do
describe 'the create order process' do
    it 'should create an order' do
      user = create(:user, email: 'asdasdsa1@gmail.com', password: '123456AAAAAaaa1!', confirmed_at: Time.now)
      visit new_user_session_path

      fill_in 'Email address', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      expect(page).to have_content 'Signed in successfully.'
      5.times do 
        visit new_order_path
        fill_in 'Title', with: 'capybara test'
        fill_in 'Description', with: 'capybara test2'
        fill_in 'Deadline', with: '02/02/2100'
        attach_file '/home/vova/Documents/123.txt' 
        click_button 'Submit Order'
        expect(page).to have_current_path(my_profile_path)
      end

      # visit new_post_path
    
      # fill_in 'Title', with: 'Post title'
      # fill_in 'Content', with: 'Post content'
    
      # click_button 'Create Post'
      # expect(page).to have_content 'Post was successfully created.'
    end
  end
end