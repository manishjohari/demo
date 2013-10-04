require 'spec_helper'

describe "products/product_details" do
   after(:all) do
    Product.delete_all
    User.delete_all
   end
   before(:each) do
     @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      @product = FactoryGirl.create(:product, user_id: @user.id, ship_internationally: true)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  it "should render the details of product" do
      assign(:product, @product)
      render
      rendered.should include("Canon")
  end
  
  #===================fail case=====================
  it "should render the details of product" do
      assign(:product, @product)
      render
      rendered.should_not include("Canon")
  end
end
