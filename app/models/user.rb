class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "ShortenedUrl"

  has_many :visited_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Visit"


    def recent_subs
      self.submitted_urls.select do |sub|
        sub.created_at > 2.minute.ago
      end
    end




end
