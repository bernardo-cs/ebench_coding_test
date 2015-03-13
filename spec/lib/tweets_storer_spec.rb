require 'spec_helper'

describe TweetsStorer do
  let(:tc) { TweetsCatcher.new }
  let(:user){ User.create( { name: 'golfadas' } ) }
  let(:ts) { TweetsStorer.new( user, { text: :text,
                                       retweets: :retweet_count,
                                       favourites: :favorite_count,
                                       source: :to_json } ) }
  before{
    @tweets ||= tc.fetch( user.name )
  }

  it 'receives a list of tweets and stores them in a user' do
    ts.store @tweets
    expect( user.tweets.count ).to eq( @tweets.count )
    expect( user.tweets.first.text ).to eq( @tweets.first.text )
    expect( user.tweets.last.retweets ).to eq( @tweets.last.retweet_count )
    expect( user.tweets.fetch( @tweets.size/2 ).favourites ).to eq( @tweets.fetch( @tweets.size/2 ).favorite_count)
  end
end
