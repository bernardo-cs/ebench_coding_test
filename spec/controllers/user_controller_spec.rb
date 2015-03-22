require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'gets all users' do
      expect( User ).to receive( :order )
      get :index
    end
    it 'assigns @users' do
      get :index
      expect(assigns(:users)).to eq([])
    end
    it 'renders index page' do
      get :index
      expect(response).to render_template('index')
    end
  end

end
