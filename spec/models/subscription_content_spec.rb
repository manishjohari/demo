require 'spec_helper'

describe SubscriptionContent do
  #pending "add some examples to (or delete) #{__FILE__}"
  after(:all) do
    SubscriptionContent.delete_all
  end
  describe "invalid" do
    it "is invalid without a subject" do
      FactoryGirl.build(:subscription_content, subject: nil).should_not be_valid
    end  
    it "is invalid without a message" do
      FactoryGirl.build(:subscription_content, message: nil).should_not be_valid
    end  
    it "is invalid without a user_type" do
      FactoryGirl.build(:subscription_content, user_type: nil).should_not be_valid
    end  
    
    it "is invalid without a message_type" do
      FactoryGirl.build(:subscription_content, mail_type: nil).should_not be_valid
    end  
    
    it "is invalid without a action" do
      FactoryGirl.build(:subscription_content, mail_type: "scheduler", action: nil).should_not be_valid
    end
    
    it "is invalid without a action_time" do
      FactoryGirl.build(:subscription_content, mail_type: "scheduler", action_time: nil).should_not be_valid
    end    
    
    it "is invalid without a module" do
      FactoryGirl.build(:subscription_content, mail_type: "scheduler", :module=>nil).should_not be_valid
    end 
  end
  
  describe "valid" do
    it "should be valid" do
      FactoryGirl.build(:subscription_content, subject: "test" , message: "msgtest", user_type: "usertype", mail_type: "mailtypetest").should be_valid
    end
  end
  
   describe "after product creation" do
    it "should retur after product creation" do
       @subs = FactoryGirl.create(:subscription_content, subject: "test" , message: "msgtest", user_type: "usertype", mail_type: "mailtypetest", :module => "product", action: "creation")
      SubscriptionContent.after_product_creation.should include @subs
    end
   end
   
   describe "after order creation" do
    it "should retur after order creation" do
       @subs = FactoryGirl.create(:subscription_content, subject: "test" , message: "msgtest", user_type: "usertype", mail_type: "mailtypetest", :module => "order", action: "creation")
      SubscriptionContent.after_order_creation.should include @subs
    end
   end
   
   #==================================fail case=============================
    describe "invalid" do
    it "is invalid without a subject" do
      FactoryGirl.build(:subscription_content, subject: nil).should be_valid
    end  
    it "is invalid without a message" do
      FactoryGirl.build(:subscription_content, message: nil).should be_valid
    end  
    it "is invalid without a user_type" do
      FactoryGirl.build(:subscription_content, user_type: nil).should be_valid
    end  
    
    it "is invalid without a message_type" do
      FactoryGirl.build(:subscription_content, mail_type: nil).should be_valid
    end  
    
    it "is invalid without a action" do
      FactoryGirl.build(:subscription_content, mail_type: "scheduler", action: nil).should be_valid
    end
    
    it "is invalid without a action_time" do
      FactoryGirl.build(:subscription_content, mail_type: "scheduler", action_time: nil).should be_valid
    end    
    
    it "is invalid without a module" do
      FactoryGirl.build(:subscription_content, mail_type: "scheduler", :module=>nil).should be_valid
    end 
  end
  
  describe "valid" do
    it "should be valid" do
      FactoryGirl.build(:subscription_content, subject: "test" , message: "msgtest", user_type: "usertype", mail_type: "mailtypetest").should_not be_valid
    end
  end
  
   describe "after product creation" do
    it "should retur after product creation" do
       @subs = FactoryGirl.create(:subscription_content, subject: "test" , message: "msgtest", user_type: "usertype", mail_type: "mailtypetest", :module => "product", action: "creation")
      SubscriptionContent.after_product_creation.should_not include @subs
    end
   end
   
   describe "after order creation" do
    it "should retur after order creation" do
       @subs = FactoryGirl.create(:subscription_content, subject: "test" , message: "msgtest", user_type: "usertype", mail_type: "mailtypetest", :module => "order", action: "creation")
      SubscriptionContent.after_order_creation.should_not include @subs
    end
   end

   
  
end
