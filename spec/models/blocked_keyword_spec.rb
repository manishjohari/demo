require 'spec_helper'

describe BlockedKeyword do
   it "has a valid factory" do
    FactoryGirl.create(:blocked_keyword).should be_valid
  end
  
  #===============fail case====================
   it "has a valid factory" do
    FactoryGirl.create(:blocked_keyword).should_not be_valid
  end
  
end
