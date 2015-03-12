require 'spec_helper'

describe TweetsCatcher do
  let(:tweet_catcher) { TweetsCatcher.new }
  before{
    @tweets ||= tweet_catcher.fetch_all_user_tweets( 'golfadas' )
  }

  it 'fetches all user tweets' do
    expect( @tweets ).not_to be_empty
    expect( @tweets.first.text ).to eq( "Dai até  não pagar impostos..“@sapo: Passos: \"Ninguém espere que eu seja um cidadão perfeito\" http://t.co/8v6eJ0nkod http://t.co/vPNUhXmtw8”" )
    expect( @tweets.last.text ).to eq( "to a rasca para ir mijar" )
  end

  it 'doesnt have repeated ids' do
    tweets = @tweets.map(&:id)
    expect( tweets.to_set.size ).to eql( tweets.size )
  end
end
