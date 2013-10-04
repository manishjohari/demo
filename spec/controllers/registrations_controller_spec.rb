require 'spec_helper'

describe RegistrationsController do
  after(:all) do
    ConfigurationSetting.delete_all
    User.delete_all
  end
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end
    end
    context "with invalid attributes" do
      it "does not save the new user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user, email: nil)
        }.to_not change(User, :count)
      end
    end
  end
  describe 'PUT update' do
    before :each do
    FactoryGirl.create(:configuration_setting)
    @user = FactoryGirl.create(:user, payment_method: true, country: "IN",  email: "test@grabsell.com",  currency: 'usd', confirmed_at: "2013-05-28 06:38:19.499604")
    @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user     
    end
    context "valid attributes" do
      it "located the requested @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: "testname" , password: "test1234", password_confirmation: "test1234", email: "testeremail@grabsell.com")
        @user.reload
        #@user.first_name.should eq("testname")
      end
    end
    context "invalid attributes" do
      it "does not change @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, email: nil, first_name: "testuser")
        @user.reload
        @user.first_name.should_not eq("testuser")
      end
    end
  end
  
  describe "change password" do
    it "should redirect to edit user registration url" do
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, email: "testerchange@test.com", confirmed_at: "2013-05-28 06:38:19.499604")
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
      get :change_password
      response.should render_template :change_password
    end 
  end
  describe "check email" do
    context "with valid attributes" do
      it "should render text success" do
        get :check_email, user: FactoryGirl.attributes_for(:user, email: "testerreg@example.com")
        response.should render_template(:text => "success")
      end
    end
    context  "with invalid attributes" do
      it "should returen errors" do
        user = FactoryGirl.build(:user, email: "")
        get :check_email, user: FactoryGirl.attributes_for(:user, email: "")
        response.should render_template(:json => user.errors.full_messages.uniq)
      end
    end
  end
  
  #========================================fail case=============================
    describe "POST create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(0)
      end
    end
    context "with invalid attributes" do
      it "does not save the new user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user, email: nil)
        }.to change(User, :count)
      end
    end
  end
  describe 'PUT update' do
    before :each do
    FactoryGirl.create(:configuration_setting)
    @user = FactoryGirl.create(:user, payment_method: true, country: "IN",  email: "test@grabsell.com",  currency: 'usd', confirmed_at: "2013-05-28 06:38:19.499604")
    @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user     
    end
    context "valid attributes" do
      it "located the requested @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: "testname" , password: "test1234", password_confirmation: "test1234", email: "testeremail@grabsell.com")
        @user.reload
        @user.first_name.should eq("testname")
      end
    end
    context "invalid attributes" do
      it "does not change @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, email: nil, first_name: "testuser")
        @user.reload
        @user.first_name.should eq("testuser")
      end
    end
  end
  
  describe "change password" do
    it "should redirect to edit user registration url" do
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, email: "testerchange@test.com", confirmed_at: "2013-05-28 06:38:19.499604")
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
      get :change_password
      response.should_not render_template :change_password
    end 
  end
  describe "check email" do
    context "with valid attributes" do
      it "should render text success" do
        get :check_email, user: FactoryGirl.attributes_for(:user, email: "testerreg@example.com")
        response.should_not render_template(:text => "success")
      end
    end
    context  "with invalid attributes" do
      it "should returen errors" do
        user = FactoryGirl.build(:user, email: "")
        get :check_email, user: FactoryGirl.attributes_for(:user, email: "")
        response.should_not render_template(:json => user.errors.full_messages.uniq)
      end
    end
  end
  
end
