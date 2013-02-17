class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  before_save { |user| user.email = email.downcase }
end
