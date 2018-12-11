require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "users can navigate from the home page to the product detail page by clicking on a product." do
    visit '/'
    within first('article.product') do
      first('h4').click
    end
    sleep 2
    save_screenshot 'description.png'
  end


end
