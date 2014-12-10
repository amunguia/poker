class ChatController < ApplicationController

  #Post a new message
  def new
  	if !current_user
      render :json => {message: "You must be logged in to enter a message", success: false}
  	else 
      if params[:message] != nil || params[:message].length == 0
        chat = Chat.new(params[:message])
        table = Table.find(params[:table_id].to_i)
        table.chat<< chat
        table.save
        current_user.chat<< chat
        current_user.save
        render :json => {success: true} 
      else
        render :json => {message: "A message cannot be empty", success: false}
      end
  	end
  end

  #Get all chats at a table after
  #a certain id. 
  def index
  	table = Table.find params[:table_id].to_i
  	result = []
    index = -1;
  	table.chat.each do |c|
      if c.id >= index
        index = c.id
      end
      
      if c.id > params[:chat_index].to_i
        result << {
        	index: c.id,
        	message: c.message,
        	username: c.user.username
        }
      end
  	end
    if params[:chat_index] == 0
      result = result.reverse[0]
    end
    if result.length > 5
      result = result.reverse.slice(0,5)
    end
    hash = {:index => index, :chats => result}
  	render :json => hash
  end

end
