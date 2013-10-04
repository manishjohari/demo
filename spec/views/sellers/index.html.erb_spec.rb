require 'spec_helper'

describe "sellers/index" do
   after(:all) do
    User.delete_all
   end
   before(:each) do
     @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
   end
   it "displays all the sellers" do
    assign(:sellers, Kaminari.paginate_array([FactoryGirl.create(:user, first_name: "test" , last_name: "seller", role: 2), FactoryGirl.create(:user, role: 2)]).page(1))
    render
    rendered.should include("seller")
   end
   
   #=======================fail case============================
   it "displays all the sellers" do
    assign(:sellers, Kaminari.paginate_array([FactoryGirl.create(:user, first_name: "test" , last_name: "seller", role: 2), FactoryGirl.create(:user, role: 2)]).page(1))
    render
    rendered.should_not include("seller")
   end
end
