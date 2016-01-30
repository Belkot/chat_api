class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  validates :text, presence: true, length: { minimum: 1 }
  validates :user, presence: true
  validates :chat, presence: true

  before_create :check_that_user_from_chat
  after_create :inc_unread_messages

  def user_name
    user.name
  end

  def create_time
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  private

  def inc_unread_messages
    ChatItem.where(chat: chat).where.not(user: user)
      .update_all 'unread_messages_count = unread_messages_count + 1'
  end

  def check_that_user_from_chat
    if chat.users.include? user
      return true
    else
      errors.add(:base, 'user not in chat')
      return false
    end
  end
end
