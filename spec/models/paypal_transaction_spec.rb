require 'spec_helper'

describe PaypalTransaction do
  it "should have valid factory" do
    FactoryGirl.create(:paypal_transaction).should be_valid
  end
  it "should belongs to seller" do
    expect {FactoryGirl.create(:paypal_transaction).seller}.to_not raise_error
  end
  #================fail case==============================
  it "should have valid factory" do
    FactoryGirl.create(:paypal_transaction).should_not be_valid
  end
  it "should belongs to seller" do
    expect {FactoryGirl.create(:paypal_transaction).seller}.to raise_error
  end

end
