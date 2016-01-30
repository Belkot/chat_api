class MessagesController < ApplicationController
  respond_to :json

  def create
    chat = Chat.find(params[:chat_id])
    if current_user.chats.include? chat
      @message = Message.new(text: message_params[:text], user: current_user, chat: chat)
      if @message.save
        render :show
      else
        render json: {}, status: 500
      end
    else
      render json: {}, status: 500
    end
  end

  def index
    chat = Chat.find(params[:chat_id])
    @messages = chat.messages.last chat.unread_messages_count(current_user)
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
