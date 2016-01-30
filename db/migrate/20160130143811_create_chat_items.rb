class CreateChatItems < ActiveRecord::Migration
  def change
    create_table :chat_items do |t|
      t.integer :unread_messages_count, default: 0
      t.references :user, index: true, foreign_key: true
      t.references :chat, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
