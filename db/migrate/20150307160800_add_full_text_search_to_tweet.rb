class AddFullTextSearchToTweet < ActiveRecord::Migration
  execute "CREATE INDEX tweets_idx ON tweets USING gin(to_tsvector('english', text ));"
end
