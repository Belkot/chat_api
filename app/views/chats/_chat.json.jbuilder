json.chat do
  json.id chat.id
  json.name chat.name
  json.user_ids chat.user_ids
  json.unread_messages_count chat.unread_messages_count(current_user)
end
