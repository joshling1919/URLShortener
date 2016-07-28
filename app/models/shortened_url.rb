require 'securerandom'
class ShortenedUrl < ActiveRecord::Base
  include SecureRandom
  validates :long_url, :short_url, presence: true
  validates :short_url, uniqueness: true
  validate :too_long?
  validate :exceeds_submission_limit?

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "Visit"

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitors

  def too_long?
    unless self.long_url.length < 50
        self.errors[:long_url] << "URL too long :("
    end
  end

  def exceeds_submission_limit?
    if self.submitter.recent_subs.count >= 5
      self.errors[:submission_error] << "too many submissions in the last min"
    end
  end


  def self.random_code
      jumbled_url = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(jumbled_url)
      jumbled_url = SecureRandom.urlsafe_base64
    end
    jumbled_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(long_url: long_url, short_url: self.random_code,
      user_id: user.id)
  end

  def num_clicks
    self.visitors.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.select(:user_id).where('created_at > ?', 10.minutes.ago).distinct.count
  end

  # def inspect
  #   "id:#{self.id}, long_url:#{self.long_url}, short_url:#{self.short_url},
  #   user_id: #{self.user_id} user_email: #{self.submitter.email} \n"
  # end

end
