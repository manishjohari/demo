require 'spec_helper'

describe HomeController do
  describe "GET #index" do
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  
  #===========================fail case============================  
  describe "GET #index" do
    it "renders the :index view" do
      get :index
      response.should_not render_template :index
    end
  end  
end
