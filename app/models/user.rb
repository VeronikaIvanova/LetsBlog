class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password
  before_create :create_remember_token
  attr_accessor :remember_token
  

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def remember
    self.update_attribute(:remember_digest, new_token)
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember 
    cookies.permanent[:remember_token] = user.remember_digest
    cookies.permament.signed[:user_id] = user.id
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
