require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new( name: 'Bob' ) }
  let(:tweet){ Tweet.create( text: 'Ho' ) }

  it 'has a name' do
    expect( user.name ).to eq 'Bob'
  end

  it 'has many tweets' do
    user.tweets << Tweet.create( text: 'Ho' )
    user.tweets << Tweet.create( text: 'Hey' )
    expect( user.tweets.size ).to eq 2
  end

  it 'is mentioned in tweets' do
    user.mentions << tweet
    expect( user.mentions ).to include tweet
  end

  it 'counter caches the number of tweets' do
    user.save
    user.mentions << tweet
    expect( user.mentions.count ).to eq( 1 )
    expect( user.mentions_count_cache ).to eq( 1 )
  end

  context 'when updating all mentions cache' do
    let(:user1) { user = User.create( name: 'ana' )
                  user.mentions << tweet
                  user}
    let(:user2) { user = User.create( name: 'ana' )
                  user.mentions << tweet
                  user}
    let(:user3) { user = User.create( name: 'ana' )
                  user.mentions << tweet
                  user}

    it 'update all users mention count' do
      User.update_mentions_count()
      expect( user1.mentions_count_cache ).to eq 1
      expect( user2.mentions_count_cache ).to eq 1
      expect( user2.mentions_count_cache ).to eq 1
    end
  end
end
