require 'spec_helper'

describe TaxDetail do
  after(:all) do
    Product.delete_all
    TaxDetail.delete_all
    ConfigurationSetting.delete_all
  end
  before(:each) do
    FactoryGirl.create(:configuration_setting)
    @product = FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage=> 10}})
  end
  
  describe "validation" do 
    
    it "is invalid without a country code" do
      FactoryGirl.build(:tax_detail,  country_code: nil, product_id: @product.id).should_not be_valid
    end
    it "is valid without a country code" do
      FactoryGirl.build(:tax_detail, country_code: "IN", product_id:@product.id).should be_valid
    end
    
    it "is invalid without percentage" do
      FactoryGirl.build(:tax_detail, percentage: nil, product_id:@product.id).should_not be_valid
    end
    
    it "is valid with a numeric percentage" do
      FactoryGirl.build(:tax_detail, percentage: 10, product_id:@product.id).should be_valid
    end
    
    it "is invalid when percentage is not a numeric" do
      FactoryGirl.build(:tax_detail, percentage: "test", product_id:@product.id).should_not be_valid
    end
    
    it "is invalid with a numeric percentage with exceed length of limit 3 digit" do
      FactoryGirl.build(:tax_detail, percentage: 1000, product_id:@product.id).should_not be_valid
    end
    
    it "is invalid with a duplicate country_code" do
      @product = FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage=> 10}})
      FactoryGirl.create(:tax_detail, country_code: "IN", percentage: 1, product_id: @product.id)
      FactoryGirl.build(:tax_detail, country_code: "IN" , product_id: @product.id).should_not be_valid
    end
  end
  
  #==================================fail case====================================
  
  describe "validation" do 
    
    it "is invalid without a country code" do
      FactoryGirl.build(:tax_detail,  country_code: nil, product_id: @product.id).should be_valid
    end
    it "is valid without a country code" do
      FactoryGirl.build(:tax_detail, country_code: "IN", product_id:@product.id).should_not be_valid
    end
    
    it "is invalid without percentage" do
      FactoryGirl.build(:tax_detail, percentage: nil, product_id:@product.id).should be_valid
    end
    
    it "is valid with a numeric percentage" do
      FactoryGirl.build(:tax_detail, percentage: 10, product_id:@product.id).should_not be_valid
    end
    
    it "is invalid when percentage is not a numeric" do
      FactoryGirl.build(:tax_detail, percentage: "test", product_id:@product.id).should be_valid
    end
    
    it "is invalid with a numeric percentage with exceed length of limit 3 digit" do
      FactoryGirl.build(:tax_detail, percentage: 1000, product_id:@product.id).should be_valid
    end
    
    it "is invalid with a duplicate country_code" do
      @product = FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage=> 10}})
      FactoryGirl.create(:tax_detail, country_code: "IN", percentage: 1, product_id: @product.id)
      FactoryGirl.build(:tax_detail, country_code: "IN" , product_id: @product.id).should be_valid
    end
  end
  
end
