require 'spec_helper'

describe Admin::BlockedIpAddressesController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    FactoryGirl.create(:configuration_setting)
    @user = FactoryGirl.create(:user, payment_method: true, role: 3,  confirmed_at: "2013-05-28 06:38:19.499604")
    @blocked_ip_address = FactoryGirl.create(:blocked_ip_address)
    @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user
  end
  describe "GET #index" do
    it "populates an array of blocked IP address" do
      get :index
      assigns(:blocked_ip_addresses).should eq([@blocked_ip_address])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested blocked ip address to @blocked_ip_address" do
      get :show, id: @blocked_ip_address
      assigns(:blocked_ip_address).should eq(@blocked_ip_address)
    end
    it "renders the #show view" do
      get :show, id: @blocked_ip_address
      response.should render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new product" do
      get :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new blocked IP address" do
        expect{
          post :create, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address)
        }.to change(BlockedIpAddress, :count).by(1)
      end
      it "redirects to the blocked ip_address address" do
        post :create, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address)
        response.should redirect_to admin_blocked_ip_address_path(BlockedIpAddress.last)
      end
    end
    context "with invalid attributes" do
      it "does not save the new block ip address" do
        expect{
          post :create, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address, ip_address: "")
        }.to_not change(BlockedIpAddress,:count)
      end
      
      it "re-renders the new method" do
        post :create, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address, ip_address: "")
        response.should render_template :new
      end
    end 
  end
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @blocked_ip_address" do
        put :update, id: @blocked_ip_address, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address)
        assigns(:blocked_ip_address).should eq(@blocked_ip_address)      
      end
    
      it "changes @blocked_ip_address's attributes" do
        put :update, id: @blocked_ip_address, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address, ip_address: "127.0.0.1")
        @blocked_ip_address.reload
        @blocked_ip_address.ip_address.should eq("127.0.0.1")
      end
    end
    context "invalid attributes" do
      
      it "locates the requested @blocked_ip_address" do
        put :update, id: @blocked_ip_address, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address, ip_address: "127.0.0.1")
        assigns(:blocked_ip_address).should eq(@blocked_ip_address)      
      end
      
      it "re-renders the edit method" do
        put :update, id: @blocked_ip_address, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address, ip_address: "")
        response.should render_template :edit
      end
    end
  end  
  describe 'DELETE destroy' do
    
    it "deletes the blocked ip_address address" do
      expect{
        delete :destroy, id: @blocked_ip_address
      }.to change(BlockedIpAddress,:count).by(-1)
    end
      
    it "redirects to blocked ip_address#index" do
      delete :destroy, id: @blocked_ip_address
      response.should redirect_to admin_blocked_ip_addresses_path
    end
  end
  
  #============================fail case==================================
  describe "GET #index" do
    it "populates an array of blocked IP address" do
      get :index
      assigns(:blocked_ip_addresses).should_not eq([@blocked_ip_address])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested blocked ip address to @blocked_ip_address" do
      get :show, id: @blocked_ip_address
      assigns(:blocked_ip_address).should_not eq(@blocked_ip_address)
    end
    it "renders the #show view" do
      get :show, id: @blocked_ip_address
      response.should_not render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new product" do
      get :new
      response.should_not render_template :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new blocked IP address" do
        expect{
          post :create, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address)
        }.to_not change(BlockedIpAddress, :count).by(1)
      end
      it "redirects to the blocked ip_address address" do
        post :create, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address)
        response.should_not redirect_to admin_blocked_ip_address_path(BlockedIpAddress.last)
      end
    end
    context "with invalid attributes" do
      it "does not save the new block ip address" do
        expect{
          post :create, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address, ip_address: "")
        }.to change(BlockedIpAddress,:count)
      end
      
      it "re-renders the new method" do
        post :create, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address, ip_address: "")
        response.should_not render_template :new
      end
    end 
  end
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @blocked_ip_address" do
        put :update, id: @blocked_ip_address, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address)
        assigns(:blocked_ip_address).should_not eq(@blocked_ip_address)      
      end
    
      it "changes @blocked_ip_address's attributes" do
        put :update, id: @blocked_ip_address, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address, ip_address: "127.0.0.1")
        @blocked_ip_address.reload
        @blocked_ip_address.ip_address.should_not eq("127.0.0.1")
      end
    end
    context "invalid attributes" do
      
      it "locates the requested @blocked_ip_address" do
        put :update, id: @blocked_ip_address, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address, ip_address: "127.0.0.1")
        assigns(:blocked_ip_address).should_not eq(@blocked_ip_address)      
      end
      
      it "re-renders the edit method" do
        put :update, id: @blocked_ip_address, blocked_ip_address: FactoryGirl.attributes_for(:blocked_ip_address, ip_address: "")
        response.should_not render_template :edit
      end
    end
  end  
  describe 'DELETE destroy' do
    
    it "deletes the blocked ip_address address" do
      expect{
        delete :destroy, id: @blocked_ip_address
      }.to_not change(BlockedIpAddress,:count).by(-1)
    end
      
    it "redirects to blocked ip_address#index" do
      delete :destroy, id: @blocked_ip_address
      response.should_not redirect_to admin_blocked_ip_addresses_path
    end
  end
end
