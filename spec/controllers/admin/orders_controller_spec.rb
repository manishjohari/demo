require 'spec_helper'

describe Admin::OrdersController do
before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, role: 3,  confirmed_at: "2013-05-28 06:38:19.499604")
      @order = FactoryGirl.create(:order)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  describe "GET #index" do
    it "populates an array of orders" do
      get :index
      assigns(:orders).should eq([@order])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested order to @order" do
      get :show, id: @order
      assigns(:order).should eq(@order)
    end
    it "renders the #show view" do
      get :show, id: @order
      response.should render_template :show
    end
  end
  
  #=====================fail case===========================
  
  describe "GET #index" do
    it "populates an array of orders" do
      get :index
      assigns(:orders).should_not eq([@order])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested order to @order" do
      get :show, id: @order
      assigns(:order).should_not eq(@order)
    end
    it "renders the #show view" do
      get :show, id: @order
      response.should_not render_template :show
    end
  end
 
end
