require 'spec_helper'

describe Admin::ProminentProductsController do
before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    FactoryGirl.create(:configuration_setting)
    @user = FactoryGirl.create(:user, payment_method: true, role: 3, confirmed_at: "2013-05-28 06:38:19.499604")
    @prominent_product = FactoryGirl.create(:prominent_product, location: 1, option: "a", slot: 1 )
    @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user
  end
  describe "GET #index" do
    it "populates an array of prominent_products" do
      get :index
      assigns(:prominent_products).should eq([@prominent_product])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end  
  describe "GET #show" do
    it "assigns the requested prominent_product to @prominent_product" do
      get :show, id: @prominent_product
      assigns(:prominent_product).should eq(@prominent_product)
    end
    it "renders the #show view" do
      get :show, id: @prominent_product
      response.should render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new prominent_product" do
      get :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new prominent_product" do
        expect{
          post :create, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "a", slot: 3 )
        }.to change(ProminentProduct, :count).by(1)
      end
      it "redirects to the prominent_product" do
        post :create, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "a", slot: 1 )
        response.should redirect_to admin_prominent_products_path
      end
    end
    context "with invalid attributes" do
      it "does not save the new prominent_product" do
        expect{
          post :create, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "", slot: 1 )
        }.to_not change(Product,:count)
      end
      
      it "re-renders the new method" do
        post :create, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "", slot: 1 )
        response.should redirect_to admin_prominent_products_path
      end
    end 
  end
  describe 'PUT update' do
    before :each do
     @new_prominent_product =  FactoryGirl.create(:prominent_product, location: 1, option: "a", slot: 2 )
    end
    
    context "valid attributes" do
      it "located the requested @prominent_product" do
        put :update, id: @new_prominent_product, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "a", slot: 2)
        assigns(:prominent_product).should eq(@new_prominent_product)      
      end
    
      it "changes @prominent_product's attributes" do
        put :update, id: @new_prominent_product, prominent_product: FactoryGirl.attributes_for(:prominent_product, option: "a") 
        @new_prominent_product.reload
        @new_prominent_product.option.should eq("a")
      end
    end
    context "invalid attributes" do
      it "locates the requested @prominent_product" do
        put :update, id: @new_prominent_product, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "a", slot: 1 )
        assigns(:prominent_product).should eq(@new_prominent_product)      
      end
      
      it "does not change @prominent_product's attributes" do
        put :update, id: @new_prominent_product, prominent_product: FactoryGirl.attributes_for(:prominent_product, option: "c" )
        @new_prominent_product.reload
        @new_prominent_product.option.should_not eq("a")
      end
      
      it "re-renders the edit method" do
        put :update, id: @new_prominent_product, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: "", option: "", slot: 1 )
        response.should redirect_to admin_prominent_products_path
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @prominent_product = FactoryGirl.create(:prominent_product, location: 1, option: "b", slot: 2 )
    end
    
    it "deletes the prominent_product" do
      expect{
        delete :destroy, id: @prominent_product        
      }.to change(ProminentProduct,:count).by(-1)
    end
      
    it "redirects to prominent_products#index" do
      delete :destroy, id: @prominent_product
      response.should redirect_to admin_prominent_products_url
    end
  end
  
  #============================================fail case=====================================
  
  describe "GET #index" do
    it "populates an array of prominent_products" do
      get :index
      assigns(:prominent_products).should_not eq([@prominent_product])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end  
  describe "GET #show" do
    it "assigns the requested prominent_product to @prominent_product" do
      get :show, id: @prominent_product
      assigns(:prominent_product).should_not eq(@prominent_product)
    end
    it "renders the #show view" do
      get :show, id: @prominent_product
      response.should_not render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new prominent_product" do
      get :new
      response.should_not render_template :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new prominent_product" do
        expect{
          post :create, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "a", slot: 3 )
        }.to_not change(ProminentProduct, :count).by(1)
      end
      it "redirects to the prominent_product" do
        post :create, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "a", slot: 1 )
        response.should_not redirect_to admin_prominent_products_path
      end
    end
    context "with invalid attributes" do
      it "does not save the new prominent_product" do
        expect{
          post :create, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "", slot: 1 )
        }.to change(Product,:count)
      end
      
      it "re-renders the new method" do
        post :create, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "", slot: 1 )
        response.should_not redirect_to admin_prominent_products_path
      end
    end 
  end
  describe 'PUT update' do
    before :each do
     @new_prominent_product =  FactoryGirl.create(:prominent_product, location: 1, option: "a", slot: 2 )
    end
    
    context "valid attributes" do
      it "located the requested @prominent_product" do
        put :update, id: @new_prominent_product, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "a", slot: 2)
        assigns(:prominent_product).should_not eq(@new_prominent_product)      
      end
    
      it "changes @prominent_product's attributes" do
        put :update, id: @new_prominent_product, prominent_product: FactoryGirl.attributes_for(:prominent_product, option: "a") 
        @new_prominent_product.reload
        @new_prominent_product.option.should_not eq("a")
      end
    end
    context "invalid attributes" do
      it "locates the requested @prominent_product" do
        put :update, id: @new_prominent_product, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: 1, option: "a", slot: 1 )
        assigns(:prominent_product).should_not eq(@new_prominent_product)      
      end
      
      it "does not change @prominent_product's attributes" do
        put :update, id: @new_prominent_product, prominent_product: FactoryGirl.attributes_for(:prominent_product, option: "c" )
        @new_prominent_product.reload
        @new_prominent_product.option.should eq("a")
      end
      
      it "re-renders the edit method" do
        put :update, id: @new_prominent_product, prominent_product: FactoryGirl.attributes_for(:prominent_product, location: "", option: "", slot: 1 )
        response.should_not redirect_to admin_prominent_products_path
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @prominent_product = FactoryGirl.create(:prominent_product, location: 1, option: "b", slot: 2 )
    end
    
    it "deletes the prominent_product" do
      expect{
        delete :destroy, id: @prominent_product        
      }.to_not change(ProminentProduct,:count).by(-1)
    end
      
    it "redirects to prominent_products#index" do
      delete :destroy, id: @prominent_product
      response.should_not redirect_to admin_prominent_products_url
    end
  end
end
