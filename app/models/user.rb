class User < ApplicationRecord
	# Create auth token on user creation
	before_create :generate_authentication_token

	has_and_belongs_to_many :tasks
  validates :facebook_id, uniqueness: true, allow_blank: :true
  before_save { self.email = email.downcase if email }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } 
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create

	validates :auth_token, uniqueness: true

	# Auth token expires after 24 hours
  def generate_authentication_token
      self.auth_token  = User.new_token
			self.auth_expires_at = Time.now + 240.hours
	end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
	
end
