require 'spec_helper'

describe Category do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid factory" do
    FactoryGirl.create(:category).should be_valid
  end
  it "should have many products" do
    expect { FactoryGirl.create(:category).products }.to_not raise_error
  end
  
  it "should have many orders" do
    expect { FactoryGirl.create(:category).orders }.to_not raise_error
  end
  
  #====================fail case=========================
  
  it "has a valid factory" do
    FactoryGirl.create(:category).should_not be_valid
  end
  it "should have many products" do
    expect { FactoryGirl.create(:category).products }.to raise_error
  end
  
  it "should have many orders" do
    expect { FactoryGirl.create(:category).orders }.to raise_error
  end
  
end
