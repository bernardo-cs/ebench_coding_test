class FetchTweetsJob < ActiveJob::Base
  queue_as :default

  def perform
    User.update_tweets
    User.update_mentions_count

    # Schedule next time it is going to fetch new tweets
    self.class.set(wait_until: Date.tomorrow.midnight).perform_later
  end
end
