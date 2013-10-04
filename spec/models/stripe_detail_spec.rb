require 'spec_helper'

describe StripeDetail do
  after(:all) do
    StripeDetail.delete_all
  end
  it "has a valid factory" do
    FactoryGirl.create(:stripe_detail).should be_valid
  end
  it "belongs to user" do
    expect {FactoryGirl.create(:stripe_detail).user}.to_not raise_error
  end
  
  #================fail case====================================
  it "has a valid factory" do
    FactoryGirl.create(:stripe_detail).should_not be_valid
  end
  it "belongs to user" do
    expect {FactoryGirl.create(:stripe_detail).user}.to raise_error
  end
  
end
