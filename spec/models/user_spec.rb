require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new( name: 'Bob' ) }

  it 'has a name' do
    expect( user.name ).to eq 'Bob'
  end

  it 'has many tweets' do
    user.tweets << Tweet.create( text: 'Ho' )
    user.tweets << Tweet.create( text: 'Hey' )
    expect( user.tweets.size ).to eq 2
  end
end
