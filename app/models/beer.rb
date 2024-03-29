class Beer < ApplicationRecord
  include RatingAverage

  validates :name, :style, presence: true

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  def to_s
    "#{name} #{brewery.name}"
  end
end
