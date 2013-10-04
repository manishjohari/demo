require 'spec_helper'

describe Admin::CrossSellProductsController do
 before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
     FactoryGirl.create(:configuration_setting)
    @cross_sell_product = FactoryGirl.create(:cross_sell_product, option: "d")
    @user = FactoryGirl.create(:user, payment_method: true, role: 3,  confirmed_at: "2013-05-28 06:38:19.499604")
    @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user
  end
  describe "GET #index" do
    it "populates an array of cross sell products" do
      get :index
      assigns(:cross_sell_products).should eq([@cross_sell_product])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @cross_sell_product" do
        put :update, id: @cross_sell_product, cross_sell_product: FactoryGirl.attributes_for(:cross_sell_product)
        assigns(:cross_sell).should eq(@cross_sell_product)      
      end
    
      it "changes @cross_sell_product's attributes" do
        put :update, id: @cross_sell_product, cross_sell_product: FactoryGirl.attributes_for(:cross_sell_product, option: "e")
        @cross_sell_product.reload
        @cross_sell_product.option.should eq("e")
      end
      
      it "changes @cross_sell_product's attributes with option specific products"  do
        put :update, id: @cross_sell_product, cross_sell_product: FactoryGirl.attributes_for(:cross_sell_product, option: "a", product: ['1','2'])
        @cross_sell_product.reload
        @cross_sell_product.option.should eq("a")
      end
     
    end
    context "invalid attributes" do
      it "locates the requested @cross_sell_product" do
        put :update, id: @cross_sell_product, cross_sell_product: FactoryGirl.attributes_for(:cross_sell_product, option: "d")
        assigns(:cross_sell).should eq(@cross_sell_product)      
      end
      
      it "re-renders the edit method" do
        put :update, id: @cross_sell_product, cross_sell_product: FactoryGirl.attributes_for(:cross_sell_product, option: "")
        response.should redirect_to admin_cross_sell_products_path
      end
    end
  end
  
  #==================fail case=====================================
  
  describe "GET #index" do
    it "populates an array of cross sell products" do
      get :index
      assigns(:cross_sell_products).should_not eq([@cross_sell_product])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end
  
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @cross_sell_product" do
        put :update, id: @cross_sell_product, cross_sell_product: FactoryGirl.attributes_for(:cross_sell_product)
        assigns(:cross_sell).should_not eq(@cross_sell_product)      
      end
    
      it "changes @cross_sell_product's attributes" do
        put :update, id: @cross_sell_product, cross_sell_product: FactoryGirl.attributes_for(:cross_sell_product, option: "e")
        @cross_sell_product.reload
        @cross_sell_product.option.should_not eq("e")
      end
      
      it "changes @cross_sell_product's attributes with option specific products"  do
        put :update, id: @cross_sell_product, cross_sell_product: FactoryGirl.attributes_for(:cross_sell_product, option: "a", product: ['1','2'])
        @cross_sell_product.reload
        @cross_sell_product.option.should_not eq("a")
      end
     
    end
    context "invalid attributes" do
      it "locates the requested @cross_sell_product" do
        put :update, id: @cross_sell_product, cross_sell_product: FactoryGirl.attributes_for(:cross_sell_product, option: "d")
        assigns(:cross_sell).should_not eq(@cross_sell_product)      
      end
      
      it "re-renders the edit method" do
        put :update, id: @cross_sell_product, cross_sell_product: FactoryGirl.attributes_for(:cross_sell_product, option: "")
        response.should_not redirect_to admin_cross_sell_products_path
      end
    end
  end 
  
end
