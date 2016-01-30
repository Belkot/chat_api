class User < ActiveRecord::Base
  has_many :messages
  has_many :chat_items
  has_many :chats, through: :chat_items

  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }

  has_secure_password
  validates :password, length: { minimum: 6 }

  def messages_count
    messages.count
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
