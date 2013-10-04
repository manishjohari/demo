require 'spec_helper'

describe Admin::UsersController do
  before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, role: 3, confirmed_at: "2013-05-28 06:38:19.499604")
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
    end
    describe "GET #index" do
      it "populates an array of users" do
        get :index
        assigns(:users).should eq([@user])
      end
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end  
    describe "GET #show" do
      it "assigns the requested user to @user" do
        get :show, id: @user
        assigns(:user).should eq(@user)
      end
      it "renders the #show view" do
        get :show, id: @user
        response.should render_template :show
      end
    end
    describe 'PUT update' do
      before :each do
        @new_user = FactoryGirl.create(:user, role: 2)
      end
      
      context "valid attributes" do
        it "located the requested @user" do
          put :update, id: @new_user, user: FactoryGirl.attributes_for(:user)
          assigns(:user).should eq(@new_user)      
        end
      end
      context "invalid attributes" do
        it "locates the requested @user" do
          put :update, id: @new_user, user: FactoryGirl.attributes_for(:user)
          assigns(:user).should eq(@new_user)      
        end
        
        it "does not change @user's attributes" do
          put :update, id: @new_user, user: FactoryGirl.attributes_for(:user, email: "")
          @new_user.reload
          @new_user.email.should_not eq("")
        end
        
        it "re-renders the edit method" do
          put :update, id: @new_user, user: FactoryGirl.attributes_for(:user, email: "")
          response.should render_template :edit
        end
      end
    end
    describe 'DELETE destroy' do
      before :each do
        @user = FactoryGirl.create(:user)
      end
      
      it "deletes the user" do
        expect{
          delete :destroy, id: @user        
        }.to change(User,:count).by(-1)
      end
        
      it "redirects to users#index" do
        delete :destroy, id: @user
        response.should redirect_to admin_users_url
      end
    end
    
    #==================================fail case=============================
    
    describe "GET #index" do
      it "populates an array of users" do
        get :index
        assigns(:users).should_not eq([@user])
      end
      it "renders the :index view" do
        get :index
        response.should_not render_template :index
      end
    end  
    describe "GET #show" do
      it "assigns the requested user to @user" do
        get :show, id: @user
        assigns(:user).should_not eq(@user)
      end
      it "renders the #show view" do
        get :show, id: @user
        response.should_not render_template :show
      end
    end
    describe 'PUT update' do
      before :each do
        @new_user = FactoryGirl.create(:user, role: 2)
      end
      
      context "valid attributes" do
        it "located the requested @user" do
          put :update, id: @new_user, user: FactoryGirl.attributes_for(:user)
          assigns(:user).should_not eq(@new_user)      
        end
      end
      context "invalid attributes" do
        it "locates the requested @user" do
          put :update, id: @new_user, user: FactoryGirl.attributes_for(:user)
          assigns(:user).should_not eq(@new_user)      
        end
        
        it "does not change @user's attributes" do
          put :update, id: @new_user, user: FactoryGirl.attributes_for(:user, email: "")
          @new_user.reload
          @new_user.email.should eq("")
        end
        
        it "re-renders the edit method" do
          put :update, id: @new_user, user: FactoryGirl.attributes_for(:user, email: "")
          response.should_not render_template :edit
        end
      end
    end
    describe 'DELETE destroy' do
      before :each do
        @user = FactoryGirl.create(:user)
      end
      
      it "deletes the user" do
        expect{
          delete :destroy, id: @user        
        }.to_not change(User,:count).by(-1)
      end
        
      it "redirects to users#index" do
        delete :destroy, id: @user
        response.should_not redirect_to admin_users_url
      end
    end
end
