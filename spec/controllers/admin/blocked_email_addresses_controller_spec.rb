require 'spec_helper'

describe Admin::BlockedEmailAddressesController do
  before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, role: 3,  confirmed_at: "2013-05-28 06:38:19.499604")
      @blocked_email_address = FactoryGirl.create(:blocked_email_address)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  describe "GET #index" do
    it "populates an array of blocked email address" do
      get :index
      assigns(:blocked_email_addresses).should eq([@blocked_email_address])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested blocked email address to @blocked_email_address" do
      get :show, id: @blocked_email_address
      assigns(:blocked_email_address).should eq(@blocked_email_address)
    end
    it "renders the #show view" do
      get :show, id: @blocked_email_address
      response.should render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new blocked email address" do
      get :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new blocked email address" do
        expect{
          post :create, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address)
        }.to change(BlockedEmailAddress, :count).by(1)
      end
      it "redirects to the blocked email address" do
        post :create, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address)
        response.should redirect_to admin_blocked_email_address_path(BlockedEmailAddress.last)
      end
    end
    context "with invalid attributes" do
      it "does not save the new block email address" do
        expect{
          post :create, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "")
        }.to_not change(BlockedEmailAddress,:count)
      end
      
      it "re-renders the new method" do
        post :create, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "")
        response.should render_template :new
      end
    end 
  end
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @blocked_email_address" do
        put :update, id: @blocked_email_address, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address)
        assigns(:blocked_email_address).should eq(@blocked_email_address)      
      end
    
      it "changes @blocked_email_address's attributes" do
        put :update, id: @blocked_email_address, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "test@grabsell.com")
        @blocked_email_address.reload
        @blocked_email_address.email.should eq("test@grabsell.com")
      end
    end
    context "invalid attributes" do
      it "locates the requested @blocked_email_address" do
        put :update, id: @blocked_email_address, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "test@grabsell.com")
        assigns(:blocked_email_address).should eq(@blocked_email_address)      
      end
      
      it "does not change @blocked_email_address attributes" do
        put :update, id: @blocked_email_address, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "")
        @blocked_email_address.reload
        @blocked_email_address.email.should_not eq("test@grabsell.com")
      end
      
      it "re-renders the edit method" do
        put :update, id: @blocked_email_address, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "")
        response.should render_template :edit
      end
    end
  end  
  describe 'DELETE destroy' do
    
    it "deletes the blocked email address" do
      expect{
        delete :destroy, id: @blocked_email_address
      }.to change(BlockedEmailAddress,:count).by(-1)
    end
      
    it "redirects to blocked email address#index" do
      delete :destroy, id: @blocked_email_address
      response.should redirect_to admin_blocked_email_addresses_path
    end
  end
  
  #=============================fail case====================================
  
    describe "GET #index" do
    it "populates an array of blocked email address" do
      get :index
      assigns(:blocked_email_addresses).should_not eq([@blocked_email_address])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested blocked email address to @blocked_email_address" do
      get :show, id: @blocked_email_address
      assigns(:blocked_email_address).should_not eq(@blocked_email_address)
    end
    it "renders the #show view" do
      get :show, id: @blocked_email_address
      response.should_not render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new blocked email address" do
      get :new
      response.should_not render_template :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new blocked email address" do
        expect{
          post :create, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address)
        }.to_not change(BlockedEmailAddress, :count).by(1)
      end
      it "redirects to the blocked email address" do
        post :create, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address)
        response.should_not redirect_to admin_blocked_email_address_path(BlockedEmailAddress.last)
      end
    end
    context "with invalid attributes" do
      it "does not save the new block email address" do
        expect{
          post :create, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "")
        }.to change(BlockedEmailAddress,:count)
      end
      
      it "re-renders the new method" do
        post :create, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "")
        response.should_not render_template :new
      end
    end 
  end
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @blocked_email_address" do
        put :update, id: @blocked_email_address, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address)
        assigns(:blocked_email_address).should_not eq(@blocked_email_address)      
      end
    
      it "changes @blocked_email_address's attributes" do
        put :update, id: @blocked_email_address, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "test@grabsell.com")
        @blocked_email_address.reload
        @blocked_email_address.email.should_not eq("test@grabsell.com")
      end
    end
    context "invalid attributes" do
      it "locates the requested @blocked_email_address" do
        put :update, id: @blocked_email_address, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "test@grabsell.com")
        assigns(:blocked_email_address).should_not eq(@blocked_email_address)      
      end
      
      it "does not change @blocked_email_address attributes" do
        put :update, id: @blocked_email_address, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "")
        @blocked_email_address.reload
        @blocked_email_address.email.should eq("test@grabsell.com")
      end
      
      it "re-renders the edit method" do
        put :update, id: @blocked_email_address, blocked_email_address: FactoryGirl.attributes_for(:blocked_email_address, email: "")
        response.should_not render_template :edit
      end
    end
  end  
  describe 'DELETE destroy' do
    
    it "deletes the blocked email address" do
      expect{
        delete :destroy, id: @blocked_email_address
      }.to_not change(BlockedEmailAddress,:count).by(-1)
    end
      
    it "redirects to blocked email address#index" do
      delete :destroy, id: @blocked_email_address
      response.should_not redirect_to admin_blocked_email_addresses_path
    end
  end
end
