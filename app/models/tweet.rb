class Tweet < ActiveRecord::Base
  belongs_to :user

  def self.search_text query
    where("to_tsvector('english', text) @@ to_tsquery(?)", query )
  end
end
