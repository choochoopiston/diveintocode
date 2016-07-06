class MessagesController < ApplicationController
  before_action :set_conversation, only: [:index, :new, :create]
  
  def index
    @messages = @conversation.messages

    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    @message = @conversation.messages.build
  end

  def new
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    @messages = @conversation.messages
    Pusher['notifications' + @message.conversation.recipient_id.to_s].trigger
    ('message', {messaging: "メッセージが届いています。：#{@message.body}"})
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      render :index
    end
  end
  
  private
    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end
    
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
    
end
