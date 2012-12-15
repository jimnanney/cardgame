require 'spec_helper'

describe "User Pages" do
  

  describe "#index" do
    subject { page }
  
    before { visit users_path }
    
    it { should have_selector("h1", :text => "Hello World") }

  end

  describe "#show" do
    
    subject { page }
    
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

    subject { page }

    #    visit new_user_path
    # Check RSPEC Docs for why before is needed to find the new_user_path
    before { visit new_user_path }

    it { should have_selector('h1', text:'New User Template') }


    # Pending "set new user signup page test"
    # visit new_user_path
  end
end

