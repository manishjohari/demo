require 'spec_helper'

describe BlockedIpAddress do
  it "has a valid factory" do
    FactoryGirl.create(:blocked_ip_address)
  end
  
  #========fail case=============
  it "has a valid factory" do
    FactoryGirl.create(:blocked_ip_address).should_not be_valid
  end

end
