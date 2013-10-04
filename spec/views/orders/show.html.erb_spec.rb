require 'spec_helper'

describe "orders/show" do
   after(:all) do
    Product.delete_all
    Order.delete_all
    User.delete_all
   end
   before(:each) do
     @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      @category = FactoryGirl.create(:category)
      @product = FactoryGirl.create(:product, name: "order product", user_id: @user.id)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  it "displays all the products" do
      assign(:order, FactoryGirl.create(:order, product_name: @product.name, category_id: @category.id))
      render
      rendered.should include("order product")
  end
  
  #==================fail case=========================
  it "displays all the products" do
      assign(:order, FactoryGirl.create(:order, product_name: @product.name, category_id: @category.id))
      render
      rendered.should_not include("order product")
  end
  
end
