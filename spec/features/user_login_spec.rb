require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create(
      email: 'test123456@test.com',
      name: 'Tester',
      password: '12356789',
      password_confirmation: '12356789'
    )
  end
  scenario "users can login successfully and are taken to the home page once they are signed in." do
    visit '/login'
    within "form" do
      fill_in 'email', with: 'test123456@test.com'
      fill_in 'password', with: '12356789'
      save_screenshot 'signin.png'
      click_button 'Submit'
    end

    save_screenshot 'loggedin_products.png'

    expect(page).to have_selector 'section.products-index'

  end

end
