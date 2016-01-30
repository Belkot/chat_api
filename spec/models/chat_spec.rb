require 'rails_helper'

describe Chat do
  it 'is valid with a name' do
    expect(build(:chat)).to be_valid
  end

  context 'is invalid' do
    it 'without a name' do
      chat = build(:chat, name: nil)
      chat.valid?
      expect(chat.errors[:name]).to include("can't be blank")
    end

    it 'with a duplicate name' do
      chat_firt = build(:chat, name: 'Mychat')
      2.times { chat_firt.users << build(:user) }
      chat_firt.save
      chat = build(:chat, name: 'Mychat')
      chat.valid?
      expect(chat.errors[:name]).to include('has already been taken')
    end

    it 'with a short name' do
      chat = build(:chat, name: '')
      chat.valid?
      expect(chat.errors[:name]).to include('is too short (minimum is 1 character)')
    end

    it 'with a long name' do
      long_name = 'a' * 21
      chat = build(:chat, name: long_name)
      chat.valid?
      expect(chat.errors[:name]).to include('is too long (maximum is 20 characters)')
    end
  end

  context 'have' do
    let(:user1) { build(:user) }
    let(:user2) { build(:user) }
    let(:chat) { build(:chat) }

    it 'unread messages count for each user' do
      chat.users << [user1, user2]
      chat.save
      3.times { create(:message, user: user1, chat: chat) }
      expect(chat.unread_messages_count(user1)).to eq 0
      expect(chat.unread_messages_count(user2)).to eq 3
    end

    it 'minimum 2 users before save' do
      chat.users << user1
      expect(chat.save).to be_falsey
      chat.users << user2
      expect(chat.save).to be_truthy
    end
  end
end
