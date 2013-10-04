require 'spec_helper'

describe "orders/new" do
 after(:all) do
    Product.delete_all
    Category.delete_all
    User.delete_all
   end
   before(:each) do
     @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      @product = FactoryGirl.create(:product, user_id: @user.id, ship_internationally: true)
      @category = FactoryGirl.create(:category)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  it "should render the template form" do
      assign(:order, FactoryGirl.build(:order))
      assign(:product, @product)
      assign(:product_variant, "")
      assign(:product_id, @product.id)
      render :partial => 'form'
  end
  describe "partial paypal payment" do
    it "should render partial paypal payment" do
      render :partial => 'paypal_payment'
    end
  end
  it "should render the template form" do
      assign(:order, FactoryGirl.build(:order))
      assign(:product, @product)
      assign(:product_variant, "")
      assign(:product_id, @product.id)
      render :partial => 'foorm'
  end
  describe "partial paypal payment" do
    it "should render partial paypal payment" do
      render :partial => 'paypal_paymentdf'
    end
  end
end
