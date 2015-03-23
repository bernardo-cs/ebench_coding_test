json.array! @users do |user|
  json.username user.name
  json.retweets_count user.count_of_mentions
end
