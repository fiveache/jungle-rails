class ReviewsController < ApplicationController
  before_filter :authorize, only: :create
  def create
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @product = Product.find params[:product_id]
    @review = {
      'user_id' => @current_user.id,
      'product_id' => params[:product_id],
      'description' => review_params[:description],
      'rating' => review_params[:rating]
    }

    review = Review.new(@review)

    review.save
    redirect_to @product
  end

  def destroy
    @product = Product.find params[:product_id]
    @review = Review.find params[:id]
    @review.destroy
    redirect_to @product, notice: 'Review deleted!'
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end
end
