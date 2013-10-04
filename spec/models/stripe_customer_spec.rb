require 'spec_helper'

describe StripeCustomer do
  after(:all) do
    StripeCustomer.delete_all
  end
  it "has a valid factory" do
    FactoryGirl.build(:stripe_customer).should be_valid
  end
  
  it "should belongs to user" do
    expect { FactoryGirl.create(:stripe_customer).user }.to_not raise_error
  end
  
  #===========================fail case=======================
  it "has a valid factory" do
    FactoryGirl.build(:stripe_customer).should_not be_valid
  end
  
  it "should belongs to user" do
    expect { FactoryGirl.create(:stripe_customer).user }.to raise_error
  end
end
