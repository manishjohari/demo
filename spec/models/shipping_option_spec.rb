require 'spec_helper'

describe ShippingOption do
  after(:all) do
    ShippingOption.delete_all
    ConfigurationSetting.delete_all
  end
  before(:each) do
    FactoryGirl.create(:configuration_setting)
  end
  it "has valid factory" do
    FactoryGirl.create(:shipping_option).should be_valid
  end
  #=======================fail case======================
  it "has valid factory" do
    FactoryGirl.create(:shipping_option).should_not be_valid
  end
  
end
