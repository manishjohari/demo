require 'spec_helper'

describe "products/show" do
  after(:all) do
    Product.delete_all
    User.delete_all
   end
   before(:each) do
     @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      new_user =  FactoryGirl.create(:user, payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      @product = FactoryGirl.create(:product, user_id: new_user.id, ship_internationally: true)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  it "displays the products" do
      assign(:product, @product)
      render
      rendered.should include("canon")
  end
  describe "rendering locals in a partial" do
    it "displays the share widget" do
      render :partial => "share_widgets.html.erb"
    end
  end
  
  #=======================fail case =====================
  it "displays the products" do
      assign(:product, @product)
      render
      rendered.should_not include("canon")
  end
  describe "rendering locals in a partial" do
    it "displays the share widget" do
      render :partial => "share_widgets.html.erb"
    end
  end
  
end
