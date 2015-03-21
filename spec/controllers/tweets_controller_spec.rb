require 'rails_helper'

RSpec.describe TweetsController, type: :controller do

  describe "GET #search" do
    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end
    it 'searches for tweets' do
      expect( Tweet ).to receive( :search_text )
      get :search, params: { q: "cat" }
    end
    it 'assigns @result' do
      get :search
      expect(assigns(:result)).to eq( [] )
    end
    it 'renders search page' do
      get :search
      expect(response).to render_template('search')
    end
  end

end
