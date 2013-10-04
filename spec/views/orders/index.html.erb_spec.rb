require 'spec_helper'

describe "orders/index" do
   after(:all) do
    Product.delete_all
    Order.delete_all
    User.delete_all
   end
   before(:each) do
     @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      new_user = FactoryGirl.create(:user, email: "testorder@grabsell.com", first_name: "test" , last_name: "order",  role: 1, payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      @product = FactoryGirl.create(:product, user_id: @user.id)
      @order = FactoryGirl.create(:order, email: new_user.email, user_id: new_user.id)
      new_user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in new_user
  end
  
  it "displays all the products" do
      assign(:orders, Kaminari.paginate_array([@order]).page(1))
      render
      rendered.should include("testorder@grabsell.com")
  end
  #====================fail case====================
  it "displays all the products" do
      assign(:orders, Kaminari.paginate_array([@order]).page(1))
      render
      rendered.should_not include("testorder@grabsell.com")
  end
  
end
