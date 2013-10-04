require 'spec_helper'

describe StripeDetailsController do
  after(:all) do
    User.delete_all
    StripeDetail.delete_all
  end
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    FactoryGirl.create(:configuration_setting)
    @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user
  end 
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new stripe detail" do
        expect{
          post :create,  access_token: "sk_test_1FqlyqphKZEHgsvFTJ2kwK1H", refresh_token: "rt_1fx7NynVw6Uhth1r6SmBn2nXwwjjLp8iNXshUAtReR3GoJjm", token_type: "bearer",  stripe_publishable_key: "pk_test_aGqimlHn3zTtLTbC7nxxcszo" , stripe_user_id: "acct_1fvd8KidFlE9ANW2JhRI" , scope: "read_only"
        }.to change(StripeDetail,:count).by(1)
      end
     
      it "redirects to the new stripe detail" do
        post :create, stripe_detail: FactoryGirl.attributes_for(:stripe_detail)
        response.should redirect_to payment_details_url
      end
    end
     context "with invalid attributes" do
      it "creates a new stripe detail" do
        expect{
          post :create, stripe_detail: FactoryGirl.attributes_for(:stripe_detail)
        }.to_not change(StripeDetail,:count)
      end
      
      it "should raise errors and redirect to payment url" do
        paypal_detail = FactoryGirl.build(:stripe_detail)
        post :create, stripe_detail: FactoryGirl.attributes_for(:stripe_detail)
        response.should redirect_to payment_details_url
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @stripe_detail = FactoryGirl.create(:stripe_detail)
    end
    
    it "deletes the stripe detail" do
      expect{
        delete :destroy, id: @stripe_detail        
      }.to change(StripeDetail,:count).by(-1)
    end
      
    it "redirects to payment details url" do
      delete :destroy, id: @stripe_detail
      response.should redirect_to payment_details_url
    end
  end
  
  #=========================fail case================================
  
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new stripe detail" do
        expect{
          post :create,  access_token: "sk_test_1FqlyqphKZEHgsvFTJ2kwK1H", refresh_token: "rt_1fx7NynVw6Uhth1r6SmBn2nXwwjjLp8iNXshUAtReR3GoJjm", token_type: "bearer",  stripe_publishable_key: "pk_test_aGqimlHn3zTtLTbC7nxxcszo" , stripe_user_id: "acct_1fvd8KidFlE9ANW2JhRI" , scope: "read_only"
        }.to change(StripeDetail,:count).by(1)
      end
     
      it "redirects to the new stripe detail" do
        post :create, stripe_detail: FactoryGirl.attributes_for(:stripe_detail)
        response.should_not redirect_to payment_details_url
      end
    end
     context "with invalid attributes" do
      it "creates a new stripe detail" do
        expect{
          post :create, stripe_detail: FactoryGirl.attributes_for(:stripe_detail)
        }.to change(StripeDetail,:count)
      end
      
      it "should raise errors and redirect to payment url" do
        paypal_detail = FactoryGirl.build(:stripe_detail)
        post :create, stripe_detail: FactoryGirl.attributes_for(:stripe_detail)
        response.should_not redirect_to payment_details_url
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @stripe_detail = FactoryGirl.create(:stripe_detail)
    end
    
    it "deletes the stripe detail" do
      expect{
        delete :destroy, id: @stripe_detail        
      }.to_not change(StripeDetail,:count).by(-1)
    end
      
    it "redirects to payment details url" do
      delete :destroy, id: @stripe_detail
      response.should_not redirect_to payment_details_url
    end
  end
end
