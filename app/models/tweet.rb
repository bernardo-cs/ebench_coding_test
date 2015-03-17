class Tweet < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :mentions, class_name: 'User', join_table: 'mentions'

  after_create :build_mentions

  def remote_id
    source["id"]
  end

  def self.search_text query
    where("to_tsvector('english', text) @@ to_tsquery(?)", query )
  end

  private
  def build_mentions
    mentions << local_mentions
  end

  def remote_mentions
    source["entities"]["user_mentions"].map{|m| m["screen_name"]}
  end

  def local_mentions
    remote_mentions.map{|m| User.find_by( name: m )}.compact
  end
end
