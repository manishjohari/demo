require 'spec_helper'

describe "payment_details/index" do
  after(:all) do
    User.delete_all
   end
   before(:each) do
     @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      @paypal_detail = FactoryGirl.create(:paypal_detail)
      @stripe_detail = FactoryGirl.create(:stripe_detail)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  it "should render the template add" do
    assign(:paypal_detail, FactoryGirl.create(:paypal_detail))
      render :partial => 'add'
  end
  it "should render paypal_detail" do
    assign(:paypal_detail, @paypal_detail)
    render :partial => 'paypal_detail'
  end
  it "should render stripe detail" do
    assign(:stripe_detail, @stripe_detail)
    render :partial => 'stripe_detail'
  end
  
  #=====================fail case=====================
  
  it "should render the template add" do
    assign(:paypal_detail, FactoryGirl.create(:paypal_detail))
      render :partial => 'adda'
  end
  it "should render paypal_detail" do
    assign(:paypal_detail, @paypal_detail)
    render :partial => 'paypal_details'
  end
  it "should render stripe detail" do
    assign(:stripe_detail, @stripe_detail)
    render :partial => 'stripe_details'
  end
end
