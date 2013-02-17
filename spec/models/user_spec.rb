require 'spec_helper'

describe User do
  before { @user = User.new(name: "John Doe", email: "jdoe@example.net") }
  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  
  it { should be_valid }

  describe "When name is not present" do
    before { @user = User.new(email: "jdoe@example.net") }
    subject { @user }
    it { should_not be_valid }
  end
  
  describe "When email is not present" do
    before { @user = User.new(name: "Joe Doe") }
    subject { @user }
    it { should_not be_valid }
  end

  describe "When two users with same email exist, regardless of case" do
    before do 
      @duplicate = User.new(name: "Jim", email: "jim@example.net")
      @duplicate.save()
      @user = User.new(name: "Joe", email: "Jim@Example.Net")
    end
    subject {@user}
    it { should_not be_valid }
  end

  describe "When two users with same email exist in the database" do
    before do 
      @duplicate = User.new(name: "Jim", email: "jim@example.net")
      @duplicate.save()
      @user = User.new(name: "Joe", email: "Jim@Example.Net")
      @user.save
    end
    subject{ @user }
    its(:id) { should be_nil }
  end
  
 end

