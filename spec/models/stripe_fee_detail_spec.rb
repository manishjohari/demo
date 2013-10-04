require 'spec_helper'

describe StripeFeeDetail do
  after(:all) do
    StripeFeeDetail.delete_all
  end
  it "has a valid factory" do
    FactoryGirl.create(:stripe_fee_detail).should be_valid
  end
  
  it "should belongs to stripe_transaction" do
    expect { FactoryGirl.create(:stripe_fee_detail).stripe_transaction}.to_not raise_error
  end
  
  #==================fail case====================================
  
  it "has a valid factory" do
    FactoryGirl.create(:stripe_fee_detail).should_not be_valid
  end
  
  it "should belongs to stripe_transaction" do
    expect { FactoryGirl.create(:stripe_fee_detail).stripe_transaction}.to raise_error
  end
  
end
