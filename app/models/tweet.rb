class Tweet < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :mentions, class_name: 'User', join_table: 'mentions'

  def self.search_text query
    where("to_tsvector('english', text) @@ to_tsquery(?)", query )
  end
end
