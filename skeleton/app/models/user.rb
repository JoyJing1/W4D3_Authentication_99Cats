# require 'bcrypt'

class User < ActiveRecord::Base
  attr_reader :password
  has_many :cats,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "Cat"

  has_many :cat_rental_requests,
  primary_key: :id,
  foreign_key: :requester_id,
  class_name: "CatRentalRequest"

  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :session_token, presence: true, uniqueness: true
  validates :password, length: {minimum: 3, allow_nil: true}
  after_initialize :ensure_session_token

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password=nil)
    return nil if password.nil?
    user = self.find_by(username: user_name)
    return user if user && user.is_password?(password)
    nil
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

end
