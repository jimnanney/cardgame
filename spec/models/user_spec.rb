require 'spec_helper'

describe User do
  before { @user = User.new(name: "John Doe", email: "jdoe@example.net",
                           password: "foobar", password_confirmation: "foobar") }
  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :authenticate }

  it { should be_valid }

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do 
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "When password is not present" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "When name is not present" do
    before { @user.name = "" }
    subject { @user }
    it { should_not be_valid }
  end
  
  describe "When email is not present" do
    before {@user.email = "" }
    it { should_not be_valid }
  end

  describe "When two users with same email exist, regardless of case" do
    before do 
      duplicate = @user.dup
      duplicate.email.upcase!
      duplicate.save()
    end
    subject {@user}
    it { should_not be_valid }
  end

  describe "When two users with same email exist in the database" do
    before do 
      duplicate = @user.dup
      duplicate.save()
      @user.save()
    end
    subject{ @user }
    # If we save, we can check the id to ensure the database enforces
    # the uniqueness as well.
    its(:id) { should be_nil }
  end
 end

