json.partial! @chat
json.messages @chat.messages do |message|
  json.id message.id
  json.text message.text
  json.create_time message.create_time
  json.user_name message.user.name
end
