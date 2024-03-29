class Brewery < ApplicationRecord
  include RatingAverage

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   only_integer: true }
  validate :year, :year_cannot_be_in_future

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def year_cannot_be_in_future
    return unless year > Time.now.year

    errors.add(:year, "can't be in the future")
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    year = 2024
    puts "changed year to #{year}"
  end
end
