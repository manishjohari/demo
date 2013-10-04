require 'spec_helper'

describe StripeTransaction do
  after(:all) do
    StripeTransaction.delete_all
  end
  it "has a valid factory" do
    FactoryGirl.build(:stripe_transaction).should be_valid
  end
  #===================fail case==========================
  it "has a valid factory" do
    FactoryGirl.build(:stripe_transaction).should_not be_valid
  end
end
