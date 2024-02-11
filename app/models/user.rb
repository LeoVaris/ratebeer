class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validate :password, :password_secure

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy

  def password_secure
    if password.nil?
      errors.add(:password, "password must be at least 4 characters")
      return
    end
    if password.length < 4
      errors.add(:password, "password must be at least 4 characters")
    end
    if password == password.downcase
      errors.add(:password, "password must contain at least one capital letter")
    end
    return unless password.chars.none?{ |c| c >= '0' && c <= '9' }

    errors.add(:password, "password must contain at least one number")
  end

  def favorite_beer
    return nil if ratings.empty?

    ratings.max_by(&:score).beer
  end

  def favorite_style
    return nil if ratings.empty?

    mp = {}
    mp2 = {}
    ratings.each { |r| mp[r.beer.style] ? mp[r.beer.style].append(r.score) : mp[r.beer.style] = [r.score] }
    mp.each { |k, v| mp2[k] = v.sum / v.length }

    mp2.max_by { |_key, value| value }.first
  end

  def favorite_brewery
    return nil if ratings.empty?

    mp = {}
    mp2 = {}
    ratings.each { |r| mp[r.beer.brewery.name] ? mp[r.beer.brewery.name].append(r.score) : mp[r.beer.brewery.name] = [r.score] }
    mp.each { |k, v| mp2[k] = v.sum / v.length }

    mp2.max_by { |_key, value| value }.first
  end
end
