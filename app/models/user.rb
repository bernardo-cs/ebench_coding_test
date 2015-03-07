class User < ActiveRecord::Base
  has_many :tweets
  has_and_belongs_to_many :mentions, class_name: 'Tweet', join_table: 'mentions'

  # Design decision: since tweets will be crawled once a day, cache can be
  # updated after crawl instead of in an active record filter
  def self.update_mentions_count
    all.map(&:update_mentions_count)
  end

  def mentions_count_cache
    count_of_mentions || update_mentions_count()
  end

  private
  def update_mentions_count
    update_attribute( :count_of_mentions, mentions.count)
    count_of_mentions
  end
end
