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
    if password.length < 4
      errors.add(:password, "password must be at least 4 characters")
    end
    if password == password.downcase
      errors.add(:password, "password must contain at least one capital letter")
    end
    return unless password.chars.none?{ |c| c >= '0' && c <= '9' }

    errors.add(:password, "password must contain at least one number")
  end
end
