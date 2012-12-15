require 'spec_helper'

describe "User Pages" do
  
  subject { page }

  describe "#index" do
  
    before { visit users_path }
    
    it { should have_selector("h1", :text => "Hello World") }

  end
end
