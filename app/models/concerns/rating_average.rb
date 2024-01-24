module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.map{ |r| r.score }.sum().to_f / ratings.size.to_f
  end
 end
