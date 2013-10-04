require 'spec_helper'

describe OrdersController do
  after(:all) do
    User.delete_all
    Product.delete_all
    Order.delete_all
    ConfigurationSetting.delete_all
  end
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    FactoryGirl.create(:configuration_setting)
    @user = FactoryGirl.create(:user, payment_method: true, currency: 'INR', confirmed_at: "2013-05-28 06:38:19.499604" , is_active: true)
    @product = FactoryGirl.create(:product, user_id: @user.id, currency: 'INR',  preview: false, preview_of: 0,  starting_inventory: 0, product_availability_time: nil, ship_internationally: true)
    @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user
  end
  def valid_attributes
    {email: "tester@example.com" , shipping_option: "ordertest" , shipping_country: "IN" , shipping_first_name: "test" , shipping_last_name: "user" , shipping_address1: "address1", shipping_city: "testcity" , shipping_state: "teststate" , shipping_zip_code: "129876", user_id: @user.id, shipping_option_id: 1, payment_method: "paypal"}
  end
  describe "GET #index" do
    it "populates an array of orders" do
      @orders = FactoryGirl.create(:order, user_id: @user.id)
      get :index
      assigns(:orders).should eq([@orders])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end  
  describe "GET #new" do
    it "assigns the new order" do
      get :new
    end
    it "should redirect to store index when session[:order_params] is nil" do
      get :new
      response.should redirect_to  store_index_path
    end     
    it "should not assigns the new order" do
      user = FactoryGirl.create(:user, payment_method: false, confirmed_at: "2013-05-28 06:38:19.499604")
      product = FactoryGirl.create(:product, user_id: user.id, :starting_inventory => 10, ship_internationally: true)
      session["order_params"] = {"product" => product.id, "quantity" => 1}
      get :new
      response.should redirect_to store_index_path
    end
    it "assigns the new order" do
      product = FactoryGirl.create(:product, user_id: @user.id, :starting_inventory => 10)
      session["order_params"] = {"product" => product.id, "quantity" => 1}
      get :new
    end
  end
  describe "GET #show" do
    before(:each) do
      @order = FactoryGirl.create(:order)
    end
    it "assigns the requested order to @order" do
      get :show, id: @order
      assigns(:order).should eq(@order)
    end
    it "renders the #show view" do
      get :show, id: @order
      response.should render_template :show
    end
  end
  
  describe "POST create" do
    before(:each) do
      FactoryGirl.create(:paypal_detail, user_id: @user.id)
    end
    context "with valid attributes" do
      it "creates a new order" do
       product = FactoryGirl.create(:product, user_id: @user.id, currency: 'INR',  preview: false, preview_of: 0,  starting_inventory: 10, product_availability_time: nil, ship_internationally: true)
       session["order_params"] = {"product" => product.id, "quantity" => 1}  
        expect{
          post :create, order: valid_attributes
        }.to change(Order, :count).by(1)
      end
    end
    context "with invalid attributes" do
      it "does not save the new order" do
        expect{
          post :create, order: FactoryGirl.attributes_for(:order)
        }.to_not change(Order,:count)
      end
    end 
  end

  describe "GET Cancel" do
    context "with invalid session" do
      it "should redirect_to store index path when session is not present" do
        get :cancel
        response.should redirect_to store_index_path
      end 
      it "should redirect to store index path when session order is not present" do
         session["order_params"] = {"product" => "", "quantity" => 1}
         get :cancel
         response.should redirect_to store_index_path
      end
    end
    context "with valid session" do
      it "should render template cancel" do
        @order = FactoryGirl.create(:order)
        session["order_params"] = {"product" => "", "quantity" => 1, "order"=> @order.id}
        get :cancel
        @order.reload
        @order.payment_status == "CANCELLED"
        response.should render_template :cancel
      end 
    end
  end
  describe "GET Cancel" do
    context "with invalid session" do
      it "should redirect_to store index path when session is not present" do
        session["order_params"] = {"order"=> ""}
        get :confirmation
        response.should redirect_to store_index_path
      end 
    end
    context "with valid session" do
      it "should redirect to show" do
        @order = FactoryGirl.create(:order, payment_status: "COMPLETED", product_id: @product.id)
        session["order_params"] = {"quantity" => 1, "order"=> @order.id}
        get :confirmation
        response.should redirect_to @order
      end
    end
  end
  
  #==============================fail case=============================================
  
  describe "GET #index" do
    it "populates an array of orders" do
      @orders = FactoryGirl.create(:order, user_id: @user.id)
      get :index
      assigns(:orders).should_not eq([@orders])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end  
  describe "GET #new" do
    it "assigns the new order" do
      get :new
    end
    it "should redirect to store index when session[:order_params] is nil" do
      get :new
      response.should_not redirect_to  store_index_path
    end     
    it "should not assigns the new order" do
      user = FactoryGirl.create(:user, payment_method: false, confirmed_at: "2013-05-28 06:38:19.499604")
      product = FactoryGirl.create(:product, user_id: user.id, :starting_inventory => 10, ship_internationally: true)
      session["order_params"] = {"product" => product.id, "quantity" => 1}
      get :new
      response.should_not redirect_to store_index_path
    end
    it "assigns the new order" do
      product = FactoryGirl.create(:product, user_id: @user.id, :starting_inventory => 10)
      session["order_params"] = nil
      get :new
    end
  end
  describe "GET #show" do
    before(:each) do
      @order = FactoryGirl.create(:order)
    end
    it "assigns the requested order to @order" do
      get :show, id: @order
      assigns(:order).should_not eq(@order)
    end
    it "renders the #show view" do
      get :show, id: @order
      response.should_not render_template :show
    end
  end
  
  describe "POST create" do
    before(:each) do
      FactoryGirl.create(:paypal_detail, user_id: @user.id)
    end
    context "with valid attributes" do
      it "creates a new order" do
       product = FactoryGirl.create(:product, user_id: @user.id, currency: 'INR',  preview: false, preview_of: 0,  starting_inventory: 10, product_availability_time: nil, ship_internationally: true)
       session["order_params"] = {"product" => product.id, "quantity" => 1}  
        expect{
          post :create, order: valid_attributes
        }.to change(Order, :count).by(0)
      end
    end
    context "with invalid attributes" do
      it "does not save the new order" do
        expect{
          post :create, order: FactoryGirl.attributes_for(:order)
        }.to change(Order,:count)
      end
    end 
  end

  describe "GET Cancel" do
    context "with invalid session" do
      it "should redirect_to store index path when session is not present" do
        get :cancel
        response.should_not redirect_to store_index_path
      end 
      it "should redirect to store index path when session order is not present" do
         session["order_params"] = {"product" => "", "quantity" => 1}
         get :cancel
         response.should_not redirect_to store_index_path
      end
    end
    context "with valid session" do
      it "should render template cancel" do
        @order = FactoryGirl.create(:order)
        session["order_params"] = {"product" => "", "quantity" => 1, "order"=> @order.id}
        get :cancel
        @order.reload
        @order.payment_status == "CANCELLED"
        response.should_not render_template :cancel
      end 
    end
  end
  describe "GET Cancel" do
    context "with invalid session" do
      it "should redirect_to store index path when session is not present" do
        session["order_params"] = {"order"=> ""}
        get :confirmation
        response.should_not redirect_to store_index_path
      end 
    end
    context "with valid session" do
      it "should redirect to show" do
        @order = FactoryGirl.create(:order, payment_status: "COMPLETED", product_id: @product.id)
        session["order_params"] = {"quantity" => 1, "order"=> @order.id}
        get :confirmation
        response.should_not redirect_to @order
      end
    end
  end
  
end
