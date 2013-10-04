require 'spec_helper'

describe Order do
  it "should have a valid factory" do
    FactoryGirl.create(:order).should be_valid
  end
  
  describe "validation" do
    it "should invalid without email" do
      FactoryGirl.build(:order, email: nil).should_not be_valid
    end
    it "should invalid without shipping first name" do
      FactoryGirl.build(:order, shipping_first_name: nil).should_not be_valid
    end
    it "should invalid without shipping last name" do
      FactoryGirl.build(:order, shipping_last_name: nil).should_not be_valid
    end
    it "should invalid without shipping address1" do
      FactoryGirl.build(:order, shipping_address1: nil).should_not be_valid
    end
    it "should invalid without shipping city" do
      FactoryGirl.build(:order, shipping_city: nil).should_not be_valid
    end
    it "should invalid without shipping state" do
      FactoryGirl.build(:order, shipping_state: nil).should_not be_valid
    end
    it "should invalid without shipping zip code" do
      FactoryGirl.build(:order, shipping_zip_code: nil).should_not be_valid
    end
  end
  
  describe "association" do
    it "should belongs to user" do
      expect { FactoryGirl.create(:order).user }.to_not raise_error
    end
    it "should belongs to product" do
      expect { FactoryGirl.create(:order).product }.to_not raise_error
    end
    it "should belongs to category" do
      expect { FactoryGirl.create(:order).category }.to_not raise_error
    end
  end
  
  #==========================fail cases=====================================
  
   it "should have a valid factory" do
    FactoryGirl.create(:order).should_not be_valid
  end
  
  describe "validation" do
    it "should invalid without email" do
      FactoryGirl.build(:order, email: nil).should be_valid
    end
    it "should invalid without shipping first name" do
      FactoryGirl.build(:order, shipping_first_name: nil).should be_valid
    end
    it "should invalid without shipping last name" do
      FactoryGirl.build(:order, shipping_last_name: nil).should be_valid
    end
    it "should invalid without shipping address1" do
      FactoryGirl.build(:order, shipping_address1: nil).should be_valid
    end
    it "should invalid without shipping city" do
      FactoryGirl.build(:order, shipping_city: nil).should be_valid
    end
    it "should invalid without shipping state" do
      FactoryGirl.build(:order, shipping_state: nil).should be_valid
    end
    it "should invalid without shipping zip code" do
      FactoryGirl.build(:order, shipping_zip_code: nil).should be_valid
    end
  end
  
  describe "association" do
    it "should belongs to user" do
      expect { FactoryGirl.create(:order).user }.to raise_error
    end
    it "should belongs to product" do
      expect { FactoryGirl.create(:order).product }.to raise_error
    end
    it "should belongs to category" do
      expect { FactoryGirl.create(:order).category }.to raise_error
    end
  end
  
 
end
