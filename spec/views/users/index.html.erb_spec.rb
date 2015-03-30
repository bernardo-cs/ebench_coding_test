require 'rails_helper'

RSpec.describe "users/index.html.erb", type: :view do
  it 'Uses an angular  controller' do
    render
    expect(rendered).to match /MainCtrl/
  end
end
