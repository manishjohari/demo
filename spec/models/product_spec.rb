require 'spec_helper'

describe Product do
  after(:all)  do
    User.delete_all
    Product.delete_all
    ConfigurationSetting.delete_all
  end
  before(:each) do
    FactoryGirl.create(:configuration_setting)
  end
  describe "invalid" do
    it "is invalid without a name" do
      FactoryGirl.build(:product, name: nil).should_not be_valid
    end  
    
    it "is invalid without a image" do
      FactoryGirl.build(:product, image: nil).should_not be_valid
    end  
    
    it "is invalid without a price" do
      FactoryGirl.build(:product, price: nil).should_not be_valid
    end  
    
    it "is invalid without a category" do
      FactoryGirl.build(:product, category_id: nil).should_not be_valid
    end  
  end
  describe "valid product" do
    it "should be valid factory" do
      FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage=> 10}}).should be_valid
    end
  end
  describe "association" do
    it "belongs to category" do
      expect{FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage=> 10}}).category}.to_not raise_error
    end
    it "belongs to user" do
      expect{FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage=> 10}}).user}.to_not raise_error
    end
  end
  
  describe "scope" do
    before :each do
      @product = FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}})
    end
    context "non expired product" do
      it "returns non expired product" do
        Product.non_expired_product.should include @product
      end
    end
    context "not deleted" do
      it "returns not deleted product" do
        Product.not_deleted.should include @product
      end
    end    
    context "active user product" do
      it "returns active user product" do
        user = FactoryGirl.create(:user, :payment_method => true, is_active: true)
        product = FactoryGirl.create(:product, user_id: user.id, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}}, preview: false, preview_of: false, starting_inventory: 10)
        Product.active_user_product.should include product
      end
    end    
  end
  
  describe "before_save" do
    before(:each) do
     @product = FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}})
    end
    it "check null belonging to it" do
      @product.starting_inventory.should == 0
    end
    it "update_product_availability_time belonging to it" do
      @product.availability_days.should == 60
    end
  end
  
  describe "methods" do
    before(:each) do
      @user = FactoryGirl.create(:user, :payment_method => true)
      @product = FactoryGirl.create(:product, user_id: @user.id, :tax_details_attributes=>{"0"=>{:country_code=>"IN", :percentage => 10}}, ship_internationally: true, starting_inventory: 10)
    end
    it "should return a valid text search" do
      Product.text_search({ :query => "canon" }, "IN").should include @product
    end
    it "should not return a valid product" do
      Product.text_search({ :query => "c" } , "IN").should_not include @product
    end
    it "should return all products" do
      Product.text_search({ :query => "" }, nil).should include @product
    end
    it "should save with hit count" do
      product = FactoryGirl.create(:product,  :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}})
      product.save_hit_count(@user).should == true
    end
    it "should return blank cross sell products" do
      @product.cross_sell_products("KLT").should eq(nil)
    end
    it "should return product list with option" do
      @cross_sell = FactoryGirl.create(:cross_sell_product, option: "c")
      @product.cross_sell_products("IN").should include @product
    end
  end
  
  describe "custom validation" do
    it "should not valid with blocked keywords" do
      block = FactoryGirl.create(:blocked_keyword)
      FactoryGirl.build(:product, name: block.keyword, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}}).should_not be_valid
    end
    it "should not valid with blocked name" do
      block = FactoryGirl.create(:blocked_name)
      user = FactoryGirl.create(:user, first_name: block.name, payment_method: true)
      FactoryGirl.build(:product, name: "test",  user_id: user.id, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}}).should_not be_valid
    end
    it "should not valid with blocked email" do
      block = FactoryGirl.create(:blocked_email_address)
      user = FactoryGirl.create(:user, first_name:"test", email: block.email, payment_method: true)
      FactoryGirl.build(:product, name: "test",  user_id: user.id, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}}).should_not be_valid
    end
    it "should not valid with blocked ip address" do
      block = FactoryGirl.create(:blocked_ip_address)
      user = FactoryGirl.create(:user, first_name:"test", current_sign_in_ip: block.ip_address, payment_method: true)
      FactoryGirl.build(:product, name: "test",  user_id: user.id, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}}).should_not be_valid
    end
  end
  
  #======================================fail case ===========================================================
  
  after(:all)  do
    User.delete_all
    Product.delete_all
    ConfigurationSetting.delete_all
  end
  before(:each) do
    FactoryGirl.create(:configuration_setting)
  end
  describe "invalid" do
    it "is invalid without a name" do
      FactoryGirl.build(:product, name: nil).should be_valid
    end  
    
    it "is invalid without a image" do
      FactoryGirl.build(:product, image: nil).should be_valid
    end  
    
    it "is invalid without a price" do
      FactoryGirl.build(:product, price: nil).should be_valid
    end  
    
    it "is invalid without a category" do
      FactoryGirl.build(:product, category_id: nil).should be_valid
    end  
  end
  describe "valid product" do
    it "should be valid factory" do
      FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage=> 10}}).should_not be_valid
    end
  end
  describe "association" do
    it "belongs to category" do
      expect{FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage=> 10}}).category}.to raise_error
    end
    it "belongs to user" do
      expect{FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage=> 10}}).user}.to raise_error
    end
  end
  
  describe "scope" do
    before :each do
      @product = FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}})
    end
    context "non expired product" do
      it "returns non expired product" do
        Product.non_expired_product.should_not include @product
      end
    end
    context "not deleted" do
      it "returns not deleted product" do
        Product.not_deleted.should_not include @product
      end
    end    
    context "active user product" do
      it "returns active user product" do
        user = FactoryGirl.create(:user, :payment_method => true, is_active: true)
        product = FactoryGirl.create(:product, user_id: user.id, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}}, preview: false, preview_of: false, starting_inventory: 10)
        Product.active_user_product.should_not include product
      end
    end    
  end
  
  describe "before_save" do
    before(:each) do
     @product = FactoryGirl.create(:product, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}})
    end
    it "check null belonging to it" do
      @product.starting_inventory.should_not == 0
    end
    it "update_product_availability_time belonging to it" do
      @product.availability_days.should_not == 60
    end
  end
  
  describe "methods" do
    before(:each) do
      @user = FactoryGirl.create(:user, :payment_method => true)
      @product = FactoryGirl.create(:product, user_id: @user.id, :tax_details_attributes=>{"0"=>{:country_code=>"IN", :percentage => 10}}, ship_internationally: true, starting_inventory: 10)
    end
    it "should return a valid text search" do
      Product.text_search({ :query => "canon" }, "IN").should_not include @product
    end
    it "should not return a valid product" do
      Product.text_search({ :query => "" } , "IN").should_not include @product
    end
    it "should return all products" do
      Product.text_search({ :query => "" }, nil).should_not include @product
    end
    it "should save with hit count" do
      product = FactoryGirl.create(:product,  :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}})
      product.save_hit_count(@user).should_not == true
    end
    it "should return blank cross sell products" do
      @product.cross_sell_products("KLT").should_not eq(nil)
    end
    it "should return product list with option" do
      @cross_sell = FactoryGirl.create(:cross_sell_product, option: "c")
      @product.cross_sell_products("IN").should_not include @product
    end
  end
  
  describe "custom validation" do
    it "should not valid with blocked keywords" do
      block = FactoryGirl.create(:blocked_keyword)
      FactoryGirl.build(:product, name: block.keyword, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}}).should be_valid
    end
    it "should not valid with blocked name" do
      block = FactoryGirl.create(:blocked_name)
      user = FactoryGirl.create(:user, first_name: block.name, payment_method: true)
      FactoryGirl.build(:product, name: "test",  user_id: user.id, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}}).should be_valid
    end
    it "should not valid with blocked email" do
      block = FactoryGirl.create(:blocked_email_address)
      user = FactoryGirl.create(:user, first_name:"test", email: block.email, payment_method: true)
      FactoryGirl.build(:product, name: "test",  user_id: user.id, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}}).should be_valid
    end
    it "should not valid with blocked ip address" do
      block = FactoryGirl.create(:blocked_ip_address)
      user = FactoryGirl.create(:user, first_name:"test", current_sign_in_ip: block.ip_address, payment_method: true)
      FactoryGirl.build(:product, name: "test",  user_id: user.id, :tax_details_attributes=>{"0"=>{:country_code=>"fff", :percentage => 10}}).should be_valid
    end
  end
  
end
