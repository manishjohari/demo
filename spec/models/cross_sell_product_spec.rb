require 'spec_helper'

describe CrossSellProduct do
  
  it "is invalid without a option" do
    FactoryGirl.build(:cross_sell_product, option: nil).should_not be_valid
  end
  
  it "is invalid with a option 'a' and if product will be not present " do
    FactoryGirl.build(:cross_sell_product, option: "a", product: nil).should_not be_valid
  end
  
  it "is valid with a product if option will be a" do
    FactoryGirl.build(:cross_sell_product, option: "a", product: "1").should be_valid
  end
  
  #======================fail case================================
  it "is invalid without a option" do
    FactoryGirl.build(:cross_sell_product, option: nil).should be_valid
  end
  
  it "is invalid with a option 'a' and if product will be not present " do
    FactoryGirl.build(:cross_sell_product, option: "a", product: nil).should be_valid
  end
  
  it "is valid with a product if option will be a" do
    FactoryGirl.build(:cross_sell_product, option: "a", product: "1").should_not be_valid
  end
  
end
