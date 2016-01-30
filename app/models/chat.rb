class Chat < ActiveRecord::Base
  has_many :messages
  has_many :chat_items
  has_many :users, through: :chat_items, validate: false

  validates :name, presence: true, uniqueness: true, length: { in: 1..20 }

  before_save :check_min_users_count

  def unread_messages_count(user)
    chat_items.find_by(user: user).try :unread_messages_count
  end

  private

  def check_min_users_count
    if users.size > 1
      return true
    else
      errors.add(:base, 'minimum 2 users')
      return false
    end
  end
end
