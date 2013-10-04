require 'spec_helper'

describe SellersController do
  before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      FactoryGirl.create(:configuration_setting)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  describe "GET #index" do
    it "populates an array of sellers" do
      get :index
      assigns(:sellers).should eq([@user])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end  
  describe "GET #show" do
    it "assigns the requested seller to @seller" do
      get :show, id: @user
      assigns(:seller).should eq(@user)
    end
    it "renders the #show view" do
      get :show, id: @user
      response.should render_template :show
    end
  end
  
  describe "GET #seller_products" do
    it "assigns the requested seller products to @products" do
      products = FactoryGirl.create(:product, user_id: @user.id)
      get :seller_products
      assigns(:products).should eq([products])
    end
  end
  
  
  #=========================fail case=======================================
  
  describe "GET #index" do
    it "populates an array of sellers" do
      get :index
      assigns(:sellers).should_not eq([@user])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end  
  describe "GET #show" do
    it "assigns the requested seller to @seller" do
      get :show, id: @user
      assigns(:seller).should_not eq(@user)
    end
    it "renders the #show view" do
      get :show, id: @user
      response.should_not render_template :show
    end
  end
  
  describe "GET #seller_products" do
    it "assigns the requested seller products to @products" do
      products = FactoryGirl.create(:product, user_id: @user.id)
      get :seller_products
      assigns(:products).should_not eq([products])
    end
  end
  
end
