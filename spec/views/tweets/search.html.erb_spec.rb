require 'rails_helper'

RSpec.describe "tweets/search.html.erb", type: :view do
  it 'displays the result as a colection of tweets' do
    assign( :result, [
      stub_model( Tweet, text: 'awesome cat' ),
      stub_model( Tweet, text: 'daz catzs' )
    ] )

    render

    expect(rendered).to match /awesome cat/
    expect(rendered).to match /daz catzs/
  end
end
