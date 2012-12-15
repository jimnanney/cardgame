class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
end
