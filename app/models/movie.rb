class Movie < ApplicationRecord
  before_save :set_slug

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  has_one_attached :movie_image

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :name, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, inclusion: { in: RATINGS }

  validate :acceptable_movie_image

  scope :released, -> { where("released_on <= ?", Time.now).order("released_on desc") }
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }
  scope :recent, ->(max=3) { released.limit(max) }

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (self.average_stars / 5) * 100.0
  end

  def flop?
    (total_gross.blank? || total_gross < 250_000_000) && average_stars < 4
  end

  def to_param
    slug
  end
  
private

  def acceptable_movie_image
    return unless movie_image.attached?

    unless movie_image.blob.byte_size <= 1.megabyte
      errors.add(:movie_image, "is too big")
    end

    acceptable_types = ['image/jpeg', 'image/png']

    unless acceptable_types.include?(movie_image.content_type)
      errors.add(:movie_image, "must be a JPEG or PNG")
    end
  end

  def set_slug
    self.slug = name.parameterize
  end
end
