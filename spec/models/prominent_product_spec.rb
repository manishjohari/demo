require 'spec_helper'

describe ProminentProduct do
  #pending "add some examples to (or delete) #{__FILE__}"
  after(:all) do
    ProminentProduct.delete_all
    ConfigurationSetting.delete_all
  end
  it "is invalid without a location" do
    FactoryGirl.build(:prominent_product, location: nil).should_not be_valid
  end
  
  it "is invalid without a slot" do
    FactoryGirl.build(:prominent_product, slot: nil).should_not be_valid
  end
  
  it "is invalid wihtout a option" do
    FactoryGirl.build(:prominent_product, option: nil).should_not be_valid
  end
  
  it "is valid with a location, option and slot" do
    FactoryGirl.build(:prominent_product, location: 1, option:"a", slot: 1).should be_valid
  end
  
  it "should invalid when product not presence with option 'f' " do
    FactoryGirl.build(:prominent_product, option: "f", location: 1, slot: 1 ).should_not be_valid
  end
  
  it "should be valid when product presence with option 'f' " do
    FactoryGirl.create(:prominent_product, option: "f", product: "canon", location: 1, slot: 1 ).should be_valid
  end
  
  #===========================fail case==========================================  
  it "is invalid without a location" do
    FactoryGirl.build(:prominent_product, location: nil).should be_valid
  end
  
  it "is invalid without a slot" do
    FactoryGirl.build(:prominent_product, slot: nil).should be_valid
  end
  
  it "is invalid wihtout a option" do
    FactoryGirl.build(:prominent_product, option: nil).should be_valid
  end
  
  it "is valid with a location, option and slot" do
    FactoryGirl.build(:prominent_product, location: 1, option:"a", slot: 1).should_not be_valid
  end
  
  it "should invalid when product not presence with option 'f' " do
    FactoryGirl.build(:prominent_product, option: "f", location: 1, slot: 1 ).should be_valid
  end
  
  it "should be valid when product presence with option 'f' " do
    FactoryGirl.create(:prominent_product, option: "f", product: "canon", location: 1, slot: 1 ).should_not be_valid
  end  
 

end
