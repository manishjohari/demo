require 'spec_helper'

describe PaymentDetailsController do
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
  describe "GET #index" do
    it "should have new paypaldetail" do
      get :index
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  #=======================fail case==============================
  describe "GET #index" do
    it "should have new paypaldetail" do
      get :index
      response.should_not render_template :index
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end
    
end
