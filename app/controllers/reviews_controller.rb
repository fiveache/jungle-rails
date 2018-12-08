class ReviewsController < ApplicationController
  def create
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @product = Product.find params[:product_id]
    @review = {
      'user_id' => @current_user.id,
      'product_id' => params[:product_id],
      'description' => review_params[:description],
      'rating' => review_params[:rating]
    }
    puts @current_user
    review = Review.new(@review)

    review.save
    redirect_to @product
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end
end
