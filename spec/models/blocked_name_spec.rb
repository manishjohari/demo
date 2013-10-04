require 'spec_helper'

describe BlockedName do
  it "has a valid factory" do
    FactoryGirl.create(:blocked_name).should be_valid
  end
  #==================fail case=================
  it "has a valid factory" do
    FactoryGirl.create(:blocked_name).should_not be_valid
  end
end
