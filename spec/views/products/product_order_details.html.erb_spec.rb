require 'spec_helper'

describe "products/product_order_details" do
  after(:all) do
    Product.delete_all
    User.delete_all
    Order.delete_all
   end
   before(:each) do
     @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, first_name: "user", last_name: "order", payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      @product = FactoryGirl.create(:product, user_id: @user.id)
      @order = FactoryGirl.create(:order, product_id: @product.id, user_id: @user.id)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  it "should render order details of product" do
      assign(:orders, Kaminari.paginate_array([@order]).page(1))
      render
      rendered.should include("user")
  end
  #========================fail case=======================
  it "should render order details of product" do
      assign(:orders, Kaminari.paginate_array([@order]).page(1))
      render
      rendered.should_not include("user")
  end
  
end
