require 'spec_helper'

describe StoreController do
  after(:all) do
    ConfigurationSetting.delete_all
    User.delete_all
    Product.delete_all
  end
  describe "GET 'index'" do
    before(:each) do
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true)
    end
    it "populates an array of products" do
      products = FactoryGirl.create(:product, user_id: @user.id, ship_internationally: true, starting_inventory: 10)  
      get :index
      assigns(:products).should eq([products])
    end
    it "populates and array of products with category" do
      products = FactoryGirl.create(:product, user_id: @user.id, category_id: 1, ship_internationally: true, starting_inventory: 10)  
      get :index, {:category=>"1"} 
      assigns(:products).should eq([products])
    end
    it "populates and array of products with text search" do
      products = FactoryGirl.create(:product, user_id: @user.id, category_id: 1, ship_internationally: true, starting_inventory: 10)  
      get :index, {:query=>"canon"} 
      assigns(:products).should eq([products])
    end
    it "populates and array of products with passing sorting column" do
      products = FactoryGirl.create(:product, user_id: @user.id, category_id: 1, ship_internationally: true, starting_inventory: 10)  
      get :index, {:category => "1", :column=>"price"} 
      assigns(:products).should eq([products])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  
  #=============================fail case===================================
  describe "GET 'index'" do
    before(:each) do
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true)
    end
    it "populates an array of products" do
      products = FactoryGirl.create(:product, user_id: @user.id, ship_internationally: true, starting_inventory: 10)  
      get :index
      assigns(:products).should_not eq([products])
    end
    it "populates and array of products with category" do
      products = FactoryGirl.create(:product, user_id: @user.id, category_id: 1, ship_internationally: true, starting_inventory: 10)  
      get :index, {:category=>"1"} 
      assigns(:products).should_not eq([products])
    end
    it "populates and array of products with text search" do
      products = FactoryGirl.create(:product, user_id: @user.id, category_id: 1, ship_internationally: true, starting_inventory: 10)  
      get :index, {:query=>"canon"} 
      assigns(:products).should_not eq([products])
    end
    it "populates and array of products with passing sorting column" do
      products = FactoryGirl.create(:product, user_id: @user.id, category_id: 1, ship_internationally: true, starting_inventory: 10)  
      get :index, {:category => "1", :column=>"price"} 
      assigns(:products).should_not eq([products])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end
  
  

end
