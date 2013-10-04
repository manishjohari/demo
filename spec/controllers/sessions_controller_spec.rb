require 'spec_helper'

describe SessionsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  it "should put a warning on invalid email or password login attempt" do
    post :create, user: FactoryGirl.attributes_for(:user, email: "tester@test.com")
    flash[:alert].should == "Invalid email or password."
  end
  it "should  put a warning message" do
    @user = FactoryGirl.create(:user, email: "tester@test.com" , password: "testuser1", password_confirmation: "testuser1")
    post :create, user: FactoryGirl.attributes_for(:user, email: "tester@test.com" , password: "testuser1", password_confirmation: "testuser1")
    flash[:alert].should_not eq("Invalid email or password.")
  end
  
  #=======================fail case=========================
  
  it "should put a warning on invalid email or password login attempt" do
    post :create, user: FactoryGirl.attributes_for(:user, email: "tester@test.com")
    flash[:alert].should_not == "Invalid email or password."
  end
  it "should  put a warning message" do
    @user = FactoryGirl.create(:user, email: "tester@test.com" , password: "testuser1", password_confirmation: "testuser1")
    post :create, user: FactoryGirl.attributes_for(:user, email: "tester@test.com" , password: "testuser1", password_confirmation: "testuser1")
    flash[:alert].should eq("Invalid email or password.")
  end
end
