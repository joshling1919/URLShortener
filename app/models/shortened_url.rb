class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :short_url, presence: true
  validates :long_url, :short_url, uniqueness: true

end
