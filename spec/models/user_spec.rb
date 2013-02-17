require 'spec_helper'

describe User do
  before { @user = User.new(name: "John Doe", email: "jdoe@example.net") }
  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  
  it { should be_valid }

  describe "When name is not present"
end

