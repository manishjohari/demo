require 'spec_helper'

describe PaypalDetailsController do
  after(:all) do
    PaypalDetail.delete_all
    User.delete_all
  end
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    FactoryGirl.create(:configuration_setting)
    @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user
  end
  describe "GET #index" do
    it "should redirect to new paypal detail" do
      @paypal = FactoryGirl.create(:paypal_detail)
    end
    it "renders the :index view" do
      get :index
      response.should redirect_to new_paypal_detail_path
    end
  end  
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new paypaldetail" do
        expect{
          post :create, paypal_detail: FactoryGirl.attributes_for(:paypal_detail)
        }.to change(PaypalDetail,:count).by(1)
      end
      
      it "redirects to the new paypaldetail" do
        post :create, paypal_detail: FactoryGirl.attributes_for(:paypal_detail)
        response.should redirect_to payment_details_url
      end
    end
     context "with invalid attributes" do
      it "creates a new paypaldetail" do
        expect{
          post :create, paypal_detail: FactoryGirl.attributes_for(:paypal_detail, :email=>"tester@test.com")
        }.to_not change(PaypalDetail,:count)
      end
      
      it "should raise errors and redirect to payment url" do
        paypal_detail = FactoryGirl.build(:paypal_detail, :email=>"tester@test.com")
        post :create, paypal_detail: FactoryGirl.attributes_for(:paypal_detail, :email=>"tester@test.com")
        response.should redirect_to payment_details_url
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @paypal_detail = FactoryGirl.create(:paypal_detail)
    end
    
    it "deletes the product" do
      expect{
        delete :destroy, id: @paypal_detail        
      }.to change(PaypalDetail,:count).by(-1)
    end
      
    it "redirects to products#index" do
      delete :destroy, id: @paypal_detail
      response.should redirect_to payment_details_url
    end
  end
  
  #=============================================fail case==================================
    describe "GET #index" do
    it "should redirect to new paypal detail" do
      @paypal = FactoryGirl.create(:paypal_detail)
    end
    it "renders the :index view" do
      get :index
      response.should_not redirect_to new_paypal_detail_path
    end
  end  
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new paypaldetail" do
        expect{
          post :create, paypal_detail: FactoryGirl.attributes_for(:paypal_detail)
        }.to_not change(PaypalDetail,:count).by(1)
      end
      
      it "redirects to the new paypaldetail" do
        post :create, paypal_detail: FactoryGirl.attributes_for(:paypal_detail)
        response.should_not redirect_to payment_details_url
      end
    end
     context "with invalid attributes" do
      it "creates a new paypaldetail" do
        expect{
          post :create, paypal_detail: FactoryGirl.attributes_for(:paypal_detail, :email=>"tester@test.com")
        }.to_not change(PaypalDetail,:count)
      end
      
      it "should raise errors and redirect to payment url" do
        paypal_detail = FactoryGirl.build(:paypal_detail, :email=>"tester@test.com")
        post :create, paypal_detail: FactoryGirl.attributes_for(:paypal_detail, :email=>"tester@test.com")
        response.should_not redirect_to payment_details_url
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @paypal_detail = FactoryGirl.create(:paypal_detail)
    end
    
    it "deletes the product" do
      expect{
        delete :destroy, id: @paypal_detail        
      }.to_not change(PaypalDetail,:count).by(-1)
    end
      
    it "redirects to products#index" do
      delete :destroy, id: @paypal_detail
      response.should_not redirect_to payment_details_url
    end
  end
end
