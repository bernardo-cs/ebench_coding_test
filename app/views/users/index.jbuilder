json.array! @users do |user|
  json.username user.name
  json.mentions_count user.count_of_mentions
end
