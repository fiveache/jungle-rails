class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @review = Review.create
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end



end
