class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.delete(' ').downcase)
    user && user.authenticate(password) ? user : nil
  end

  has_many :reviews

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :password_confirmation, presence: true
end
