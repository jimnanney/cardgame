require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "#index" do
    before { visit users_path }
    it { should have_selector("h1", :text => "Hello World") }
  end

  describe "#show" do
    
    let(:user) do
      FactoryGirl.create(:user)
    end

    # Why does the symbol not work for the visit user path, and the user without symbol does work?
    # Check the FactoryGirl Docs?
    # or Capybara Docs
    # or Rails user_path doc
    before { visit user_path(user) }

    it { should have_selector("h1", :text => "User Show Page") }
    it { should have_selector("h2", :text => user.name) }

  end

  describe "#new" do
    #    visit new_user_path
    # Check RSPEC Docs for why before is needed to find the new_user_path
    before { visit new_user_path }

    it { should have_selector('h1', text:'New User Template') }
    it { should have_selector('#user_email') }
    it { should have_selector('#user_name') }
    it { should have_selector('#user_password') }
    it { should have_selector('#user_password_confirmation') }

    # Pending "set new user signup page test"
    # visit new_user_path
  end

  describe "#edit" do

   let(:user) do
     FactoryGirl.create(:user)
   end
   let(:new_name) { "Test User" }
   let(:new_email) { "testuser@example" }

   before { visit edit_user_path(user) }
   
   it { should have_selector('h1', :text => "Edit User") }
   it { should have_selector('h2', :text => "#{user.name}") }

   it { should have_field('user_name', :with => "#{user.name}") }
   it { should have_field('user_email', :with => "#{user.email}") }
   it { should have_field('user_password') }
   it { should have_field('user_password_confirmation') }
  
    describe "update with valid info" do
      before do
        fill_in "user_name", :with => new_name
        fill_in "user_email", :with => new_email
        fill_in "user_password", with: "foobarpass"
        fill_in "user_password_confirmation", with: "foobarpass"
        click_button 'Update User'
       end

      it { should have_selector("h1", :text => "User Show Page") }
      it { should have_selector("div.alert.alert-success") }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end

  end

  describe "#create" do
    before do
      visit new_user_path 
      fill_in "Name", with:"Better Typist"
      fill_in "Email", with: "lolcat@example.com"
      fill_in "user_password", with: "foobarpass"
      fill_in "user_password_confirmation", with: "foobarpass"
    end
    it "should create user" do
      expect { click_button "Create User" }.to change(User, :count).by(1)
      should have_selector("h1", :text => "User Show Page")
      should have_selector("h2", :text => "Better Typist")
    end
  end

  describe "#destroy" do
    before do
      @user = User.new 
      @user.name = "Horrid Typist"
      @user.save
      @user.destroy
    end

    it "Should be nil" do
      User.find_by_name("Horrid Typist").should be_nil
    end

  end
end

