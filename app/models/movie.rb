class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through :reviews, source: :user

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :name, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(png|jpg)\z/i,
    message: "must be a JPG or a PNG image"
  }
  validates :rating, inclusion: { in: RATINGS }

  def self.released
    Movie.where("released_on <= ?", Time.now).order("released_on desc")
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (self.average_stars / 5) * 100.0
  end

  def flop?
    (total_gross.blank? || total_gross < 250_000_000) && average_stars < 4
  end
end
