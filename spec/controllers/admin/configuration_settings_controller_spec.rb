require 'spec_helper'

describe Admin::ConfigurationSettingsController do
   before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @configuration_setting = FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, role: 3,  confirmed_at: "2013-05-28 06:38:19.499604")
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  describe "GET #index" do
    it "should redirect to show" do
      get :index
      redirect_to admin_configuration_settings_path
    end
    
  end
  describe "GET #show" do
    it "assigns the requested configuration setting to @configuration setting" do
      get :show, id: @configuration_setting
      assigns(:configuration_setting).should eq(@configuration_setting)
    end
    it "renders the #show view" do
      get :show, id: @configuration_setting
      response.should render_template :show
    end
  end
  
  
  describe 'PUT update' do
   
    context "valid attributes" do
      it "located the requested @configuration_setting" do
        put :update, id: @configuration_setting, configuration_setting: FactoryGirl.attributes_for(:configuration_setting, commission_calculated_on:["","price"])
        assigns(:configuraiton_setting).should eq(@configuraiton_setting)      
      end
    
      it "changes @configuration_setting's attributes" do
        put :update, id: @configuration_setting, configuration_setting: FactoryGirl.attributes_for(:configuration_setting, auto_sign_out_duration: 1, commission_calculated_on:["","price"])
        @configuration_setting.reload
        @configuration_setting.auto_sign_out_duration.should eq(1)
      end
    end
    context "invalid attributes" do
      it "locates the requested @configuration_setting" do
        put :update, id: @configuration_setting, configuration_setting: FactoryGirl.attributes_for(:configuration_setting, auto_sign_out_duration: 1, commission_calculated_on:["","price"])
        assigns(:configuration_setting).should eq(@configuration_setting)      
      end
      
      it "re-renders the edit method" do
        put :update, id: @configuration_setting, configuration_setting: FactoryGirl.attributes_for(:configuration_setting, auto_sign_out_duration: "", commission_calculated_on:["","price"])
        response.should render_template :edit
      end
    end
  end  
end
