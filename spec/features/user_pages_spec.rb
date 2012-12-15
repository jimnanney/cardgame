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

    before { visit user_path(user) }

    it { should have_selector("h1", :text => "User Show Page") }
  end

end

