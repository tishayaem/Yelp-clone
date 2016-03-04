class ReviewsController < ApplicationController
before_action :authenticate_user!, :except => [:index, :show]
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review review_params, current_user
    if @review.save
      redirect_to restaurants_path
    else
      if @review_errors[:user]
        redirect_to restaurants_path, alert: 'You have alredy reviewed this restaurant'
      else
        render :new
      end
    end
  end


  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = 'Review deleted successfully'
    redirect_to '/restaurants'
  end
end
