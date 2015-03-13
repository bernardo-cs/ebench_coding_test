## Fetches tweets by username
## Twitter gem wrapper

class TweetsCatcher
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        =ENV['TWITTER_KEY']
      config.consumer_secret     =ENV['TWITTER_SECRET']
      config.access_token        =ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret =ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def fetch_latest_tweets username, tweet_id
    tweets = fetch_without_rate_limite{ fetch( username ) }
    fetch_without_rate_limite do
      while( tweets.last.id > tweet_id )
        tweets.concat( fetch( username, default_args_with_max_id( tweets.flatten.last.id ) ) )
      end
      tweets.flatten.select{ |t| t.id > tweet_id }
    end
  end

  def fetch_all_user_tweets username
    tweets = fetch_without_rate_limite{ fetch(username) }
    remaining_tweets = fetch_remaining_tweets( username, tweets.last.id )
    ( tweets << remaining_tweets ).flatten
  end

  def fetch_remaining_tweets username, latest_tweet_id, args=default_args()
    fetch_without_rate_limite do
      tweets = []
      loop do
        resp = fetch( username, default_args_with_max_id( latest_tweet_id - 1 ) )
        break if resp.size == 0
        latest_tweet_id = resp.last.id
        tweets << resp
      end
      tweets.flatten
    end
  end

  def fetch username, args={count: 200, include_rts: false}
    client.user_timeline( username, args )
  end

  private
  def client
    @client
  end

  def default_args_with_max_id id
    default_args.tap{|x| x[:max_id] = id }
  end

  def default_args
    {count: 200, include_rts: false}
  end

  def fetch_without_rate_limite &block
    tweets = []
    begin
      tweets << yield
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in + 1
      retry
    end
    tweets.flatten
  end
end
