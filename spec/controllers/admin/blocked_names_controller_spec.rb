require 'spec_helper'

describe Admin::BlockedNamesController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    FactoryGirl.create(:configuration_setting)
    @user = FactoryGirl.create(:user, payment_method: true, role: 3,  confirmed_at: "2013-05-28 06:38:19.499604")
    @blocked_name = FactoryGirl.create(:blocked_name)
    @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user
  end
  describe "GET #index" do
    it "populates an array of blocked name" do
      get :index
      assigns(:blocked_names).should eq([@blocked_name])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested blocked name  to @blocked_name" do
      get :show, id: @blocked_name
      assigns(:blocked_name).should eq(@blocked_name)
    end
    it "renders the #show view" do
      get :show, id: @blocked_name
      response.should render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new blocked name" do
      get :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new blocked name" do
        expect{
          post :create, blocked_name: FactoryGirl.attributes_for(:blocked_name)
        }.to change(BlockedName, :count).by(1)
      end
      it "redirects to the blocked name" do
        post :create, blocked_name: FactoryGirl.attributes_for(:blocked_name)
        response.should redirect_to admin_blocked_name_path(BlockedName.last)
      end
    end
    context "with invalid attributes" do
      it "does not save the new block name" do
        expect{
          post :create, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "")
        }.to_not change(BlockedName,:count)
      end
      
      it "re-renders the new method" do
        post :create, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "")
        response.should render_template :new
      end
    end 
  end
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @blocked_name" do
        put :update, id: @blocked_name, blocked_name: FactoryGirl.attributes_for(:blocked_name)
        assigns(:blocked_name).should eq(@blocked_name)      
      end
    
      it "changes @blocked_name's attributes" do
        put :update, id: @blocked_name, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "testgrabsell")
        @blocked_name.reload
        @blocked_name.name.should eq("testgrabsell")
      end
    end
    context "invalid attributes" do
      it "locates the requested @blocked_name" do
        put :update, id: @blocked_name, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "testgrabsell")
        assigns(:blocked_name).should eq(@blocked_name)      
      end
      
      it "does not change @blocked_name attributes" do
        put :update, id: @blocked_name, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "")
        @blocked_name.reload
        @blocked_name.name.should_not eq("testgrabsell")
      end
      
      it "re-renders the edit method" do
        put :update, id: @blocked_name, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "")
        response.should render_template :edit
      end
    end
  end  
  describe 'DELETE destroy' do
    
    it "deletes the blocked name" do
      expect{
        delete :destroy, id: @blocked_name
      }.to change(BlockedName,:count).by(-1)
    end
      
    it "redirects to blocked name#index" do
      delete :destroy, id: @blocked_name
      response.should redirect_to admin_blocked_names_path
    end
  end
  
  #==========================fail case=======================
  
  describe "GET #index" do
    it "populates an array of blocked name" do
      get :index
      assigns(:blocked_names).should_not eq([@blocked_name])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested blocked name  to @blocked_name" do
      get :show, id: @blocked_name
      assigns(:blocked_name).should_not eq(@blocked_name)
    end
    it "renders the #show view" do
      get :show, id: @blocked_name
       response.should_not render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new blocked name" do
      get :new
        response.should_not render_template :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new blocked name" do
        expect{
          post :create, blocked_name: FactoryGirl.attributes_for(:blocked_name)
        }.to_not change(BlockedName, :count).by(1)
      end
      it "redirects to the blocked name" do
        post :create, blocked_name: FactoryGirl.attributes_for(:blocked_name)
        response.should_not redirect_to admin_blocked_name_path(BlockedName.last)
      end
    end
    context "with invalid attributes" do
      it "does not save the new block name" do
        expect{
          post :create, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "")
        }.to change(BlockedName,:count)
      end
      
      it "re-renders the new method" do
        post :create, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "")
        response.should_not render_template :new
      end
    end 
  end
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @blocked_name" do
        put :update, id: @blocked_name, blocked_name: FactoryGirl.attributes_for(:blocked_name)
        assigns(:blocked_name).should_not eq(@blocked_name)      
      end
    
      it "changes @blocked_name's attributes" do
        put :update, id: @blocked_name, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "testgrabsell")
        @blocked_name.reload
        @blocked_name.name.should_not eq("testgrabsell")
      end
    end
    context "invalid attributes" do
      it "locates the requested @blocked_name" do
        put :update, id: @blocked_name, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "testgrabsell")
        assigns(:blocked_name).should_not eq(@blocked_name)      
      end
      
      it "does not change @blocked_name attributes" do
        put :update, id: @blocked_name, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "")
        @blocked_name.reload
        @blocked_name.name.should eq("testgrabsell")
      end
      
      it "re-renders the edit method" do
        put :update, id: @blocked_name, blocked_name: FactoryGirl.attributes_for(:blocked_name, name: "")
        response.should_not render_template :edit
      end
    end
  end  
  describe 'DELETE destroy' do
    
    it "deletes the blocked name" do
      expect{
        delete :destroy, id: @blocked_name
      }.to_not change(BlockedName,:count).by(-1)
    end
      
    it "redirects to blocked name#index" do
      delete :destroy, id: @blocked_name
      response.should_not redirect_to admin_blocked_names_path
    end
  end
end
