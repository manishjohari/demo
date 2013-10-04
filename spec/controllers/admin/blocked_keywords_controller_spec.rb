require 'spec_helper'

describe Admin::BlockedKeywordsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    FactoryGirl.create(:configuration_setting)
    @user = FactoryGirl.create(:user, payment_method: true, role: 3,  confirmed_at: "2013-05-28 06:38:19.499604")
    @blocked_keyword = FactoryGirl.create(:blocked_keyword)
    @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user
  end
  describe "GET #index" do
    it "populates an array of blocked keyword" do
      get :index
      assigns(:blocked_keywords).should eq([@blocked_keyword])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested blocked keyword  to @blocked_keyword" do
      get :show, id: @blocked_keyword
      assigns(:blocked_keyword).should eq(@blocked_keyword)
    end
    it "renders the #show view" do
      get :show, id: @blocked_keyword
      response.should render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new blocked keyword" do
      get :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new blocked keyword" do
        expect{
          post :create, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword)
        }.to change(BlockedKeyword, :count).by(1)
      end
      it "redirects to the blocked keyword" do
        post :create, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword)
        response.should redirect_to admin_blocked_keyword_path(BlockedKeyword.last)
      end
    end
    context "with invalid attributes" do
      it "does not save the new block keyword" do
        expect{
          post :create, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "")
        }.to_not change(BlockedKeyword,:count)
      end
      
      it "re-renders the new method" do
        post :create, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "")
        response.should render_template :new
      end
    end 
  end
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @blocked_keyword" do
        put :update, id: @blocked_keyword, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword)
        assigns(:blocked_keyword).should eq(@blocked_keyword)      
      end
    
      it "changes @blocked_keyword's attributes" do
        put :update, id: @blocked_keyword, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "testgrabsell")
        @blocked_keyword.reload
        @blocked_keyword.keyword.should eq("testgrabsell")
      end
    end
    context "invalid attributes" do
      it "locates the requested @blocked_keyword" do
        put :update, id: @blocked_keyword, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "testgrabsell")
        assigns(:blocked_keyword).should eq(@blocked_keyword)      
      end
      
      it "does not change @blocked_keyword attributes" do
        put :update, id: @blocked_keyword, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "")
        @blocked_keyword.reload
        @blocked_keyword.keyword.should_not eq("testgrabsell")
      end
      
      it "re-renders the edit method" do
        put :update, id: @blocked_keyword, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "")
        response.should render_template :edit
      end
    end
  end  
  describe 'DELETE destroy' do
    
    it "deletes the blocked keyword" do
      expect{
        delete :destroy, id: @blocked_keyword
      }.to change(BlockedKeyword,:count).by(-1)
    end
      
    it "redirects to blocked keyword#index" do
      delete :destroy, id: @blocked_keyword
      response.should redirect_to admin_blocked_keywords_path
    end
  end
  
  #==========================fail case===================================
  
  describe "GET #index" do
    it "populates an array of blocked keyword" do
      get :index
      assigns(:blocked_keywords).should_not eq([@blocked_keyword])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested blocked keyword  to @blocked_keyword" do
      get :show, id: @blocked_keyword
      assigns(:blocked_keyword).should_not eq(@blocked_keyword)
    end
    it "renders the #show view" do
      get :show, id: @blocked_keyword
      response.should_not render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new blocked keyword" do
      get :new
      response.should_not render_template :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new blocked keyword" do
        expect{
          post :create, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword)
        }.to_not change(BlockedKeyword, :count).by(1)
      end
      it "redirects to the blocked keyword" do
        post :create, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword)
        response.should_not redirect_to admin_blocked_keyword_path(BlockedKeyword.last)
      end
    end
    context "with invalid attributes" do
      it "does not save the new block keyword" do
        expect{
          post :create, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "")
        }.to change(BlockedKeyword,:count)
      end
      
      it "re-renders the new method" do
        post :create, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "")
        response.should_not render_template :new
      end
    end 
  end
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @blocked_keyword" do
        put :update, id: @blocked_keyword, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword)
        assigns(:blocked_keyword).should_not eq(@blocked_keyword)      
      end
    
      it "changes @blocked_keyword's attributes" do
        put :update, id: @blocked_keyword, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "testgrabsell")
        @blocked_keyword.reload
        @blocked_keyword.keyword.should_not eq("testgrabsell")
      end
    end
    context "invalid attributes" do
      it "locates the requested @blocked_keyword" do
        put :update, id: @blocked_keyword, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "testgrabsell")
        assigns(:blocked_keyword).should_not eq(@blocked_keyword)      
      end
      
      it "does not change @blocked_keyword attributes" do
        put :update, id: @blocked_keyword, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "")
        @blocked_keyword.reload
        @blocked_keyword.keyword.should eq("testgrabsell")
      end
      
      it "re-renders the edit method" do
        put :update, id: @blocked_keyword, blocked_keyword: FactoryGirl.attributes_for(:blocked_keyword, keyword: "")
        response.should_not render_template :edit
      end
    end
  end  
  describe 'DELETE destroy' do
    
    it "deletes the blocked keyword" do
      expect{
        delete :destroy, id: @blocked_keyword
      }.to_not change(BlockedKeyword,:count).by(-1)
    end
      
    it "redirects to blocked keyword#index" do
      delete :destroy, id: @blocked_keyword
      response.should_not redirect_to admin_blocked_keywords_path
    end
  end
end
