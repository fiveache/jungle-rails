require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    @category = Category.find_or_create_by! name: 'Apparel'

    @product = Product.new(
      name: 'Item',
      price: 100,
      quantity: 10,
      category: @category
    )
  end

  describe 'Validations' do
    it 'is not valid without a name' do
      @product.name = nil
      expect(@product).not_to be_valid
    end

    it 'is not valid without a price' do
      @product.price_cents = nil
      expect(@product).not_to be_valid
    end

    it 'is not valid without a quantity' do
      @product.quantity = nil
      expect(@product).not_to be_valid
    end

    it 'is not valid without a category' do
      @product.category = nil
      expect(@product).not_to be_valid
    end

    it 'is valid with a name, price, quantity, and category' do
      expect(@product).to be_valid
    end
  end
end
