class Restaurant < ActiveRecord::Base
has_many :reviews, dependent: :destroy
validates :name, length: {minimum: 3}, uniqueness: true

  def build_review(attributes = {}, user)
    review = reviews.build(attributes)
    review.user = user
    review
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) {|memo, review| memo + review.rating} / reviews.count
    reviews.average(:rating)
  end

end
