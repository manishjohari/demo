require 'spec_helper'

describe ConfigurationSetting do
  after(:all) do
    ConfigurationSetting.delete_all
  end
  it "has a valid factory" do
    FactoryGirl.create(:configuration_setting).should be_valid    
  end
  it "is invalid without auto_sign_out_duration" do
    FactoryGirl.build(:configuration_setting, auto_sign_out_duration: nil).should_not be_valid
  end
  it "is valid without mobile_verification" do
    FactoryGirl.build(:configuration_setting, mobile_verification: nil).should be_valid
  end
  it "is invalid without delete_product" do
    FactoryGirl.build(:configuration_setting, delete_product: nil).should_not be_valid
  end
  it "is invalid without block_product_display" do
    FactoryGirl.build(:configuration_setting, block_product_display: nil).should_not be_valid
  end
  it "is invalid without membership_fees_per_month" do
    FactoryGirl.build(:configuration_setting, membership_fees_per_month: nil).should_not be_valid
  end
  
  it "is invalid without commission_percent" do
    FactoryGirl.build(:configuration_setting, commission_premium_percent: nil).should_not be_valid
  end
  
  it "is invalid when auto_sign_out is not a numeric" do
    FactoryGirl.build(:configuration_setting, auto_sign_out_duration: "jkl").should_not be_valid
  end
  
  it "is invalid when delete_product a numeric" do
    FactoryGirl.build(:configuration_setting, delete_product: "adk").should_not be_valid
  end
  it "is invalid when block_product_display is not a numeric" do
    FactoryGirl.build(:configuration_setting, block_product_display: "gdada").should_not be_valid
  end
  it "is invalid when membership_fees_per_month is not a numeric" do
    FactoryGirl.build(:configuration_setting, membership_fees_per_month: "dad").should_not be_valid
  end
  
  it "is invalid when commission_percent is not a numeric" do
    FactoryGirl.build(:configuration_setting, commission_premium_percent: nil).should_not be_valid
  end
  
  it "should be valid with auto_sign_out_duration" do
    FactoryGirl.build(:configuration_setting, auto_sign_out_duration: 20).should be_valid
  end
  
   it "should be valid with delete_product" do
    FactoryGirl.build(:configuration_setting, delete_product: 6).should be_valid
  end                                                                                                                                    
  it "should be valid with block_product_display " do
    FactoryGirl.build(:configuration_setting, block_product_display: 4).should be_valid
  end
  it "should be valid with membership_fees_per_month" do
    FactoryGirl.build(:configuration_setting, membership_fees_per_month: 20).should be_valid
  end
  
  it "is valid with commission_premium_percent" do
    FactoryGirl.build(:configuration_setting, commission_premium_percent: 20).should be_valid
  end
  
  #===========================================fail cases==================================
  
   it "has a valid factory" do
    FactoryGirl.create(:configuration_setting).should_not be_valid    
  end
  it "is invalid without auto_sign_out_duration" do
    FactoryGirl.build(:configuration_setting, auto_sign_out_duration: 123).should_not be_valid
  end
  it "is valid without mobile_verification" do
    FactoryGirl.build(:configuration_setting, mobile_verification: 122).should_not be_valid
  end
  it "is invalid without delete_product" do
    FactoryGirl.build(:configuration_setting, delete_product: 2).should_not be_valid
  end
  it "is invalid without block_product_display" do
    FactoryGirl.build(:configuration_setting, block_product_display: 20).should_not be_valid
  end
  it "is invalid without membership_fees_per_month" do
    FactoryGirl.build(:configuration_setting, membership_fees_per_month: 20).should_not be_valid
  end
  
  it "is invalid without commission_percent" do
    FactoryGirl.build(:configuration_setting, commission_premium_percent: 20).should_not be_valid
  end
  
  it "is invalid when auto_sign_out is not a numeric" do
    FactoryGirl.build(:configuration_setting, auto_sign_out_duration: 20).should_not be_valid
  end
  
  it "is invalid when delete_product a numeric" do
    FactoryGirl.build(:configuration_setting, delete_product: 3).should_not be_valid
  end
  it "is invalid when block_product_display is not a numeric" do
    FactoryGirl.build(:configuration_setting, block_product_display: 20).should_not be_valid
  end
  it "is invalid when membership_fees_per_month is not a numeric" do
    FactoryGirl.build(:configuration_setting, membership_fees_per_month: 20).should_not be_valid
  end
  
  it "is invalid when commission_percent is not a numeric" do
    FactoryGirl.build(:configuration_setting, commission_premium_percent: 20).should_not be_valid
  end
  
  it "should be valid with auto_sign_out_duration" do
    FactoryGirl.build(:configuration_setting, auto_sign_out_duration: dakaka).should be_valid
  end
  
   it "should be valid with delete_product" do
    FactoryGirl.build(:configuration_setting, delete_product: jdkak).should be_valid
  end                                                                                                                                    
  it "should be valid with block_product_display " do
    FactoryGirl.build(:configuration_setting, block_product_display: dadajdank).should be_valid
  end
  it "should be valid with membership_fees_per_month" do
    FactoryGirl.build(:configuration_setting, membership_fees_per_month: djajda).should be_valid
  end
  
  it "is valid with commission_premium_percent" do
    FactoryGirl.build(:configuration_setting, commission_premium_percent: kxkal).should be_valid
  end
  #====================================================================
end

