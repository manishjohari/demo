require 'spec_helper'

describe ProductsController do
  after(:all) do
    User.delete_all
    Product.delete_all
  end
  before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:configuration_setting)
      @user = FactoryGirl.create(:user, payment_method: true, confirmed_at: "2013-05-28 06:38:19.499604")
      @product = FactoryGirl.create(:product, user_id: @user.id)
      @user.confirm! # set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @user
  end
  describe "GET #index" do
    it "populates an array of products" do
      get :index
      assigns(:products).should eq([@product])
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end  
  describe "GET #show" do
    it "assigns the requested product to @product" do
      get :show, id: @product
      assigns(:product).should eq(@product)
    end
    it "renders the #show view" do
      get :show, id: @product
      response.should render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new product" do
      get :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      test_photo = ActionDispatch::Http::UploadedFile.new({
        :filename => 'test_photo_1.jpg',
        :type => 'image/jpeg',
        :tempfile => File.new("#{Rails.root}/app/assets/images/rails.png")
      })
      imagefile =  File.new(Rails.root + 'app/assets/images/rails.png') 
      it "creates a new product" do
        expect{
          post :create, product: FactoryGirl.attributes_for(:product, user_id: @user.id, category_id: 1, :image=> test_photo)
        }.to change(Product, :count).by(1)
      end
      it "redirects to the product" do
        post :create, product: FactoryGirl.attributes_for(:product, user_id: @user.id, category_id: 1, :image=> test_photo)
        response.should redirect_to Product.last
      end
    end
    context "with invalid attributes" do
      it "does not save the new product" do
        expect{
          post :create, product: FactoryGirl.attributes_for(:product)
        }.to_not change(Product,:count)
      end
      
      it "re-renders the new method" do
        post :create, product: FactoryGirl.attributes_for(:product)
        response.should render_template :new
      end
    end 
  end
  describe 'PUT update' do
    before :each do
       @test_photo = ActionDispatch::Http::UploadedFile.new({
        :filename => 'test_photo_1.jpg',
        :type => 'image/jpeg',
        :tempfile => File.new("#{Rails.root}/app/assets/images/rails.png")
      })
      @new_product = FactoryGirl.create(:product, user_id: @user.id, category_id: 1, :image=> @test_photo,  :tax_details_attributes=> {"0"=>{:country_code=>"IN", :percentage=> 10}},  :shipping_options_attributes=> {"0" => {:name => "shipupdate", :price=>10}})
    end
    
    context "valid attributes" do
      it "located the requested @product" do
        put :update, id: @new_product, product: FactoryGirl.attributes_for(:product, user_id: @user.id, category_id: 1, :image=> @test_photo)
        assigns(:product).should eq(@new_product)      
      end
    
      it "changes @product's attributes" do
        put :update, id: @new_product, product: FactoryGirl.attributes_for(:product, name: "polotees",  user_id: @user.id, category_id: 1, :image=> @test_photo)
        @new_product.reload
        @new_product.name.should eq("polotees")
      end
    end
    context "invalid attributes" do
      it "locates the requested @product" do
        put :update, id: @new_product, product: FactoryGirl.attributes_for(:product, name: "polotees",  user_id: @user.id, category_id: 1, :image=> @test_photo)
        assigns(:product).should eq(@new_product)      
      end
      
      it "does not change @product's attributes" do
        put :update, id: @new_product, product: FactoryGirl.attributes_for(:product, name: "",  user_id: @user.id, category_id: 1, :image=> @test_photo)
        @new_product.reload
        @new_product.name.should_not eq("polotees")
      end
      
      it "re-renders the edit method" do
        put :update, id: @new_product, product: FactoryGirl.attributes_for(:product, name: "",  user_id: @user.id, category_id: 1, :image=> @test_photo)
        response.should render_template :edit
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @product = FactoryGirl.create(:product, user_id: @user.id)
    end
    
    it "deletes the product" do
      expect{
        delete :destroy, id: @product        
      }.to change(Product,:count).by(-1)
    end
      
    it "redirects to products#index" do
      delete :destroy, id: @product
      response.should redirect_to products_url
    end
  end
  
  #==============================fail case========================================
  
    describe "GET #index" do
    it "populates an array of products" do
      get :index
      assigns(:products).should_not eq([@product])
    end
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end  
  describe "GET #show" do
    it "assigns the requested product to @product" do
      get :show, id: @product
      assigns(:product).should_not eq(@product)
    end
    it "renders the #show view" do
      get :show, id: @product
      response.should_not render_template :show
    end
  end
  describe "GET #new" do
    it "assigns the new product" do
      get :new
      response.should_not render_template :new
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      test_photo = ActionDispatch::Http::UploadedFile.new({
        :filename => 'test_photo_1.jpg',
        :type => 'image/jpeg',
        :tempfile => File.new("#{Rails.root}/app/assets/images/rails.png")
      })
      imagefile =  File.new(Rails.root + 'app/assets/images/rails.png') 
      it "creates a new product" do
        expect{
          post :create, product: FactoryGirl.attributes_for(:product, user_id: @user.id, category_id: 1, :image=> test_photo)
        }.to_not change(Product, :count).by(1)
      end
      it "redirects to the product" do
        post :create, product: FactoryGirl.attributes_for(:product, user_id: @user.id, category_id: 1, :image=> test_photo)
        response.should_not redirect_to Product.last
      end
    end
    context "with invalid attributes" do
      it "does not save the new product" do
        expect{
          post :create, product: FactoryGirl.attributes_for(:product)
        }.to change(Product,:count)
      end
      
      it "re-renders the new method" do
        post :create, product: FactoryGirl.attributes_for(:product)
        response.should_not render_template :new
      end
    end 
  end
  describe 'PUT update' do
    before :each do
       @test_photo = ActionDispatch::Http::UploadedFile.new({
        :filename => 'test_photo_1.jpg',
        :type => 'image/jpeg',
        :tempfile => File.new("#{Rails.root}/app/assets/images/rails.png")
      })
      @new_product = FactoryGirl.create(:product, user_id: @user.id, category_id: 1, :image=> @test_photo,  :tax_details_attributes=> {"0"=>{:country_code=>"IN", :percentage=> 10}},  :shipping_options_attributes=> {"0" => {:name => "shipupdate", :price=>10}})
    end
    
    context "valid attributes" do
      it "located the requested @product" do
        put :update, id: @new_product, product: FactoryGirl.attributes_for(:product, user_id: @user.id, category_id: 1, :image=> @test_photo)
        assigns(:product).should_not eq(@new_product)      
      end
    
      it "changes @product's attributes" do
        put :update, id: @new_product, product: FactoryGirl.attributes_for(:product, name: "polotees",  user_id: @user.id, category_id: 1, :image=> @test_photo)
        @new_product.reload
        @new_product.name.should_not eq("polotees")
      end
    end
    context "invalid attributes" do
      it "locates the requested @product" do
        put :update, id: @new_product, product: FactoryGirl.attributes_for(:product, name: "polotees",  user_id: @user.id, category_id: 1, :image=> @test_photo)
        assigns(:product).should_not eq(@new_product)      
      end
      
      it "does not change @product's attributes" do
        put :update, id: @new_product, product: FactoryGirl.attributes_for(:product, name: "",  user_id: @user.id, category_id: 1, :image=> @test_photo)
        @new_product.reload
        @new_product.name.should eq("polotees")
      end
      
      it "re-renders the edit method" do
        put :update, id: @new_product, product: FactoryGirl.attributes_for(:product, name: "",  user_id: @user.id, category_id: 1, :image=> @test_photo)
        response.should_not render_template :edit
      end
    end
  end
  describe 'DELETE destroy' do
    before :each do
      @product = FactoryGirl.create(:product, user_id: @user.id)
    end
    
    it "deletes the product" do
      expect{
        delete :destroy, id: @product        
      }.to_not change(Product,:count).by(-1)
    end
      
    it "redirects to products#index" do
      delete :destroy, id: @product
      response.should_not redirect_to products_url
    end
  end
end
