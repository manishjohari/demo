require 'spec_helper'

describe Admin::SubscriptionContentsController do
   before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, role: 3, confirmed_at: "2013-05-28 06:38:19.499604")
      @subscription_content = FactoryGirl.create(:subscription_content)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
    end
    describe "GET #index" do
      it "populates an array of subscription_contents" do
        get :index
        assigns(:subscription_contents).should eq([@subscription_content])
      end
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end  
    describe "GET #show" do
      it "assigns the requested subscription_content to @subscription_content" do
        get :show, id: @subscription_content
        assigns(:subscription_content).should eq(@subscription_content)
      end
      it "renders the #show view" do
        get :show, id: @subscription_content
        response.should render_template :show
      end
    end
    describe "GET #new" do
      it "assigns the new subscription_content" do
        get :new
      end
    end
    describe "POST create" do
      context "with valid attributes" do
        it "creates a new subscription_content" do
          expect{
            post :create, subscription_content: FactoryGirl.attributes_for(:subscription_content)
          }.to change(SubscriptionContent, :count).by(1)
        end
        it "redirects to the subscription_content" do
          post :create, subscription_content: FactoryGirl.attributes_for(:subscription_content)
          response.should redirect_to admin_subscription_content_path(SubscriptionContent.last)
        end
      end
      context "with invalid attributes" do
        it "does not save the new subscription_content" do
          expect{
            post :create, subscription_content: FactoryGirl.attributes_for(:subscription_content, subject: "")
          }.to_not change(SubscriptionContent,:count)
        end
        
        it "re-renders the new method" do
          post :create, subscription_content: FactoryGirl.attributes_for(:subscription_content, subject: "")
          response.should render_template :new
        end
      end 
    end
    describe 'PUT update' do
      before :each do
        @new_subscription_content = FactoryGirl.create(:subscription_content)
      end
      
      context "valid attributes" do
        it "located the requested @subscription_content" do
          put :update, id: @new_subscription_content, subscription_content: FactoryGirl.attributes_for(:subscription_content)
          assigns(:subscription_content).should eq(@new_subscription_content)      
        end
      
        it "changes @subscription_content's attributes" do
          put :update, id: @new_subscription_content, subscription_content: FactoryGirl.attributes_for(:subscription_content, subject: "testertest")
          @new_subscription_content.reload
          @new_subscription_content.subject.should eq("testertest")
        end
      end
      context "invalid attributes" do
        it "locates the requested @subscription_content" do
          put :update, id: @new_subscription_content, subscription_content: FactoryGirl.attributes_for(:subscription_content)
          assigns(:subscription_content).should eq(@new_subscription_content)      
        end
        
        it "does not change @subscription_content's attributes" do
          put :update, id: @new_subscription_content, subscription_content: FactoryGirl.attributes_for(:subscription_content, subject: "")
          @new_subscription_content.reload
          @new_subscription_content.subject.should_not eq("")
        end
        
        it "re-renders the edit method" do
          put :update, id: @new_subscription_content, subscription_content: FactoryGirl.attributes_for(:subscription_content, subject: "")
          response.should render_template :edit
        end
      end
    end
    describe 'DELETE destroy' do
      before :each do
        @subscription_content = FactoryGirl.create(:subscription_content)
      end
      
      it "deletes the subscription_content" do
        expect{
          delete :destroy, id: @subscription_content        
        }.to change(SubscriptionContent,:count).by(-1)
      end
        
      it "redirects to subscription_contents#index" do
        delete :destroy, id: @subscription_content
        response.should redirect_to admin_subscription_contents_url
      end
    end
    
    #=================================fail case=============================
    
    describe "GET #index" do
      it "populates an array of subscription_contents" do
        get :index
        assigns(:subscription_contents).should_not eq([@subscription_content])
      end
      it "renders the :index view" do
        get :index
        response.should_not render_template :index
      end
    end  
    describe "GET #show" do
      it "assigns the requested subscription_content to @subscription_content" do
        get :show, id: @subscription_content
        assigns(:subscription_content).should_not eq(@subscription_content)
      end
      it "renders the #show view" do
        get :show, id: @subscription_content
        response.should_not render_template :show
      end
    end
    describe "GET #new" do
      it "assigns the new subscription_content" do
        get :new
        response.should_not render_template :new
      end
    end
    describe "POST create" do
      context "with valid attributes" do
        it "creates a new subscription_content" do
          expect{
            post :create, subscription_content: FactoryGirl.attributes_for(:subscription_content)
          }.to_not change(SubscriptionContent, :count).by(1)
        end
        it "redirects to the subscription_content" do
          post :create, subscription_content: FactoryGirl.attributes_for(:subscription_content)
          response.should_not redirect_to admin_subscription_content_path(SubscriptionContent.last)
        end
      end
      context "with invalid attributes" do
        it "does not save the new subscription_content" do
          expect{
            post :create, subscription_content: FactoryGirl.attributes_for(:subscription_content, subject: "")
          }.to change(SubscriptionContent,:count)
        end
        
        it "re-renders the new method" do
          post :create, subscription_content: FactoryGirl.attributes_for(:subscription_content, subject: "")
          response.should_not render_template :new
        end
      end 
    end
    describe 'PUT update' do
      before :each do
        @new_subscription_content = FactoryGirl.create(:subscription_content)
      end
      
      context "valid attributes" do
        it "located the requested @subscription_content" do
          put :update, id: @new_subscription_content, subscription_content: FactoryGirl.attributes_for(:subscription_content)
          assigns(:subscription_content).should_not eq(@new_subscription_content)      
        end
      
        it "changes @subscription_content's attributes" do
          put :update, id: @new_subscription_content, subscription_content: FactoryGirl.attributes_for(:subscription_content, subject: "testertest")
          @new_subscription_content.reload
          @new_subscription_content.subject.should_not eq("testertest")
        end
      end
      context "invalid attributes" do
        it "locates the requested @subscription_content" do
          put :update, id: @new_subscription_content, subscription_content: FactoryGirl.attributes_for(:subscription_content)
          assigns(:subscription_content).should_not eq(@new_subscription_content)      
        end
        
        it "does not change @subscription_content's attributes" do
          put :update, id: @new_subscription_content, subscription_content: FactoryGirl.attributes_for(:subscription_content, subject: "")
          @new_subscription_content.reload
          @new_subscription_content.subject.should eq("")
        end
        
        it "re-renders the edit method" do
          put :update, id: @new_subscription_content, subscription_content: FactoryGirl.attributes_for(:subscription_content, subject: "")
          response.should_not render_template :edit
        end
      end
    end
    describe 'DELETE destroy' do
      before :each do
        @subscription_content = FactoryGirl.create(:subscription_content)
      end
      
      it "deletes the subscription_content" do
        expect{
          delete :destroy, id: @subscription_content        
        }.to_not change(SubscriptionContent,:count).by(-1)
      end
        
      it "redirects to subscription_contents#index" do
        delete :destroy, id: @subscription_content
        response.should_not redirect_to admin_subscription_contents_url
      end
    end
end
