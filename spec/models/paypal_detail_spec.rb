require 'spec_helper'

describe PaypalDetail do

  it "has a valid factory" do
    @user = FactoryGirl.create(:user)
    FactoryGirl.create(:paypal_detail, user_id: @user.id).should be_valid
  end

  it "is invalid without a email" do
    FactoryGirl.build(:paypal_detail, email: nil).should_not be_valid
  end  
  
  it "is invalid without a first_name" do
    FactoryGirl.build(:paypal_detail, first_name: nil).should_not be_valid
  end
  
  it "is invalid without a last_name" do
    FactoryGirl.build(:paypal_detail, last_name: nil).should_not be_valid
  end    

  it "belongs to the user" do
    expect { FactoryGirl.create(:paypal_detail).user }.to_not raise_error
  end
  
  #====================fail case ==========================================
  
  it "has a valid factory" do
    @user = FactoryGirl.create(:user)
    FactoryGirl.create(:paypal_detail, user_id: @user.id).should_not be_valid
  end

  it "is invalid without a email" do
    FactoryGirl.build(:paypal_detail, email: nil).should be_valid
  end  
  
  it "is invalid without a first_name" do
    FactoryGirl.build(:paypal_detail, first_name: nil).should be_valid
  end
  
  it "is invalid without a last_name" do
    FactoryGirl.build(:paypal_detail, last_name: nil).should be_valid
  end    

  it "belongs to the user" do
    expect { FactoryGirl.create(:paypal_detail).user }.to raise_error
  end
  
end
