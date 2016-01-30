require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { build(:user) }
  let(:chat) { build(:chat) }

  before do
    chat.users << user
    chat.save
  end

  it 'is valid with a text' do
    message = create(:message, user: user, chat: chat)
    message.valid?
    expect(message).to be_valid
  end

  context 'is invalid' do
    it 'without a text' do
      message = build(:message, text: nil, user: user, chat: chat)
      message.valid?
      expect(message.errors[:text]).to include("can't be blank")
    end

    it 'with a short text' do
      message = build(:message, text: '', user: user, chat: chat)
      message.valid?
      expect(message.errors[:text]).to include('is too short (minimum is 1 character)')
    end

    it 'without a user' do
      message = build(:message, user: nil, chat: chat)
      message.valid?
      expect(message.errors[:user]).to include("can't be blank")
    end

    it 'without a chat' do
      message = build(:message, user: user, chat: nil)
      message.valid?
      expect(message.errors[:chat]).to include("can't be blank")
    end
  end

  it 'user name' do
    message = build(:message, user: user, chat: chat)
    expect(message.user_name).to eq user.name
  end

  it 'create time' do
    message = create(:message, user: user, chat: chat)
    expect(message.create_time).to eq message.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  it 'after create increment unread count for other user from chat' do
    user2 = build(:user)
    chat.users << [user, user2]
    3.times { create(:message, user: user, chat: chat) }
    expect(chat.unread_messages_count(user2)).to eq 3
    expect(chat.unread_messages_count(user)).to eq 0
  end
end
