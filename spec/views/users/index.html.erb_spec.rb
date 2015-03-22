require 'rails_helper'

RSpec.describe "users/index.html.erb", type: :view do
  before{
    assign( :users, [
      stub_model( User, name: 'tenderlove', count_of_mentions: 5 ),
      stub_model( User, name: 'dhh', count_of_mentions: 4 )
    ] )
  }
  it 'displays all users' do
    render
    expect(rendered).to match /tenderlove/
    expect(rendered).to match /dhh/
  end
end
