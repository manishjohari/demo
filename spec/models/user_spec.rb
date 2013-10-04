require 'spec_helper'

describe User do
  after(:all) do
    ConfigurationSetting.delete_all
    User.delete_all
  end
  it "is invalid without email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end
  
  it "is invalid without password" do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end
  
  it "has valid factory" do
    FactoryGirl.build(:user).should be_valid
  end
  
  it "is invalid with duplicate email address" do
    FactoryGirl.create(:user, email: "tester@test.com")
    FactoryGirl.build(:user, email: "tester@test.com").should_not be_valid
  end
  
  it "returns a contacts full name as a string" do
    FactoryGirl.create(:user, first_name: "test", last_name: "user").full_name.should eq "test user"
  end
  
  it "has many products" do
    expect { FactoryGirl.create(:user).products }.to_not raise_error
  end
  
  it "has one paypal detail" do
    expect { FactoryGirl.create(:user).paypal_detail }.to_not raise_error
  end
  
  it "has one stripe detail" do
    expect { FactoryGirl.create(:user).stripe_detail }.to_not raise_error
  end
  
  it "has many paypal transactions" do
    expect { FactoryGirl.create(:user).paypal_transactions }.to_not raise_error
  end
  
  it "has many orders" do
    expect { FactoryGirl.create(:user).orders }.to_not raise_error
  end
  
  it "has many stripe customers" do
    expect { FactoryGirl.create(:user).stripe_customers }.to_not raise_error
  end
  
  describe "active user" do
    before :each do
      @user = FactoryGirl.create(:user, role: 1)
    end   
    
    context "active user" do
      it "returns active user" do
        User.active_user.should include @user
      end
    end
    
    context "seller" do
      it "returns a seller" do
        User.seller.should include @user
      end
    end
    
    context "search" do
      it "return a user with email" do
        User.search(@user.email).should include @user
      end
      it "should not return a user with invalid email" do
        User.search("spectest@gmail.com").should_not include @user
      end
    end
  end
  
  #======================fail case========================================
  
  it "is invalid without email" do
    FactoryGirl.build(:user, email: nil).should be_valid
  end
  
  it "is invalid without password" do
    FactoryGirl.build(:user, password: nil).should be_valid
  end
  
  it "has valid factory" do
    FactoryGirl.build(:user).should_not be_valid
  end
  
  it "is invalid with duplicate email address" do
    FactoryGirl.create(:user, email: "tester@test.com")
    FactoryGirl.build(:user, email: "tester@test.com").should be_valid
  end
  
  it "returns a contacts full name as a string" do
    FactoryGirl.create(:user, first_name: "test", last_name: "user").full_name.should_not eq "test user"
  end
  
  it "has many products" do
    expect { FactoryGirl.create(:user).products }.to raise_error
  end
  
  it "has one paypal detail" do
    expect { FactoryGirl.create(:user).paypal_detail }.to raise_error
  end
  
  it "has one stripe detail" do
    expect { FactoryGirl.create(:user).stripe_detail }.to raise_error
  end
  
  it "has many paypal transactions" do
    expect { FactoryGirl.create(:user).paypal_transactions }.to raise_error
  end
  
  it "has many orders" do
    expect { FactoryGirl.create(:user).orders }.to raise_error
  end
  
  it "has many stripe customers" do
    expect { FactoryGirl.create(:user).stripe_customers }.to raise_error
  end
  
  describe "active user" do
    before :each do
      @user = FactoryGirl.create(:user, role: 1)
    end   
    
    context "active user" do
      it "returns active user" do
        User.active_user.should_not include @user
      end
    end
    
    context "seller" do
      it "returns a seller" do
        User.seller.should_not include @user
      end
    end
    
    context "search" do
      it "return a user with email" do
        User.search(@user.email).should_not include @user
      end
      it "should not return a user with invalid email" do
        User.search("spectest@gmail.com").should include @user
      end
    end
  end
  
end
