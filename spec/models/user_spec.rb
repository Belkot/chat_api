require 'rails_helper'

describe User do
  it 'is valid with a name' do
    expect(build(:user)).to be_valid
  end

  context 'is invalid' do
    it 'without a name' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'with a duplicate name' do
      create(:user, name: 'MyUser')
      user = build(:user, name: 'MyUser')
      user.valid?
      expect(user.errors[:name]).to include('has already been taken')
    end

    it 'with a short name' do
      user = build(:user, name: 'Us')
      user.valid?
      expect(user.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    it 'with a long name' do
      long_name = 'a' * 21
      user = build(:user, name: long_name)
      user.valid?
      expect(user.errors[:name]).to include('is too long (maximum is 20 characters)')
    end
  end

  it 'return messages count' do
    user = build(:user)
    chat = build(:chat)
    chat.users << user
    2.times { create(:message, user: user, chat: chat) }
    expect(user.messages_count).to eq 2
  end
end
