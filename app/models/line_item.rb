class LineItem < ActiveRecord::Base
  after_create :reduce_product_quantities

  def reduce_product_quantities
    @product = Product.find(product.id)
    puts @product.inspect
    @product.quantity -= quantity
    @product.save
  end

  belongs_to :order
  belongs_to :product

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true
end
