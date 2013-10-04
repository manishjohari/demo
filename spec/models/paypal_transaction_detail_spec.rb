require 'spec_helper'

describe PaypalTransactionDetail do
  it "should have valid factory" do
    FactoryGirl.create(:paypal_transaction_detail).should be_valid
  end
  it "should belongs to paypal transaction" do
    expect {FactoryGirl.create(:paypal_transaction_detail).paypal_transaction}.to_not raise_error
  end
  
  #================fail case=================================
  it "should have valid factory" do
    FactoryGirl.create(:paypal_transaction_detail).should_not be_valid
  end
  it "should belongs to paypal transaction" do
    expect {FactoryGirl.create(:paypal_transaction_detail).paypal_transaction}.to raise_error
  end
end
