require 'rails_helper'

RSpec.describe "tweets/search.html.erb", type: :view do

  before{
    assign( :result, [
      stub_model( Tweet, text: 'awesome cat' ),
      stub_model( Tweet, text: 'daz catzs' )
    ] )
  }

  it 'displays the result as a colection of tweets' do

    render

    expect(rendered).to match /awesome cat/
    expect(rendered).to match /daz catzs/
  end
  it 'displays a form to search the tweets' do
    render
    expect(rendered).to match /form/
  end
end
