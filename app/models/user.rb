class User < ActiveRecord::Base
  has_many :reviews

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true

end
