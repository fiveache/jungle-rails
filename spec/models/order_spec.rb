require 'rails_helper'
describe 'After creation' do
  before :each do
    # Setup at least two products with different quantities, names, etc
    cat1 = Category.find_or_create_by! name: 'Apparel'
    cat2 = Category.find_or_create_by! name: 'Electronics'

    @product1 = cat1.products.create!(
      name: 'Women\'s Classy shirt',
      description: 'Ooh! It\'s classy',
      # image: open_asset('apparel1.jpg'),
      quantity: 100,
      price: 79.99
    )
    @product2 = cat2.products.create!(
      name: 'Men\'s Zebra pants',
      description: 'Is that a stripe on your pants or are you just happy or Zee me?',
      # image: open_asset('apparel2.jpg'),
      quantity: 18,
      price: 114.99
    )
    # Setup at least one product that will NOT be in the order
    @product3 = cat2.products.create!(
      name: 'Mug',
      description: 'Is that coffee?',
      # image: open_asset('apparel2.jpg'),
      quantity: 8,
      price: 4.99
    )
  end
  # pending test 1
  it 'deducts quantity from products based on their line item quantities' do
    # TODO: Implement based on hints below
    # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
    @order = Order.create(
      email: 'test@test.com',
      total_cents: 0,
      stripe_charge_id: 123
    )

    # 2. build line items on @order
    @order.line_items.create(
      product: @product1,
      quantity: 2,
      item_price: @product1.price,
      total_price: @product1.price * 2
    )

    @order.line_items.create(
      product: @product2,
      quantity: 1,
      item_price: @product2.price,
      total_price: @product2.price
    )

    # 3. save! the order - ie raise an exception if it fails (not expected)
    @order.save!

    # 4. reload products to have their updated quantities
    @product1.reload
    @product2.reload
    @product3.reload
    # 5. use RSpec expect syntax to assert their new quantity values

    # expect(@product1.quantity).to eq 98
    expect(@product2.quantity).to eq 17
  end

  # pending test 2

  it 'does not deduct quantity from products that are not in the order' do
    expect(@product3.quantity).to eq 8
  end
end
