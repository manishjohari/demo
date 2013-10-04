require 'spec_helper'

describe BlockedEmailAddress do
  it "has a valid factory" do
    FactoryGirl.create(:blocked_email_address)
  end
  
  #==========fail case======================
   it "has a valid factory" do
    FactoryGirl.create(:blocked_email_address).should_not be_valid
  end
end
