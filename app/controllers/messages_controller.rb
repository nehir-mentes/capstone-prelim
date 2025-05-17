require 'dotenv/load'
ENV.fetch("OPENAI_TOKEN")

class MessagesController < ApplicationController
  def create
  # Create the user message
  the_message = Message.new
  the_message.content = params.fetch("query_content")
  the_message.role = "user"
  the_message.session_id = params.fetch("query_session_id")

  if the_message.valid?
    the_message.save

    # Find the session
    the_session = Session.find(the_message.session_id)

  
    # Fetch full history (including the just-saved user message)
    the_history = the_session.messages.order(:created_at)

    # Reconstruct conversation from full history
    chat = OpenAI::Chat.new
    the_history.each do |msg|
      case msg.role
      when "system"
        chat.system(msg.content)
      when "user"
        chat.user(msg.content)
      when "assistant"
        chat.assistant(msg.content)
      end
    end

    # Generate assistant response using full context
    assistant_response = chat.assistant!

    # Save the new assistant response
    assistant_message = Message.new(
      session_id: the_session.id,
      role: "assistant",
      content: assistant_response
    )
    assistant_message.save

    # Redirect back to the session page
    redirect_to("/sessions/#{the_message.session_id}", { :notice => "Message created successfully." })
  else
    redirect_to("/sessions/#{the_message.session_id}", alert: the_message.errors.full_messages.to_sentence)
  end
  end

  def update
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    the_message.content = params.fetch("query_content")
    the_message.role = params.fetch("query_role")
    the_message.session_id = params.fetch("query_session_id")

    if the_message.valid?
      the_message.save
      redirect_to("/messages/#{the_message.id}", { :notice => "Message updated successfully."} )
    else
      redirect_to("/messages/#{the_message.id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    the_message.destroy

    redirect_to("/messages", { :notice => "Message deleted successfully."} )
  end
end






  # def index
    # matching_messages = Message.all

    # @list_of_messages = matching_messages.order({ :created_at => :desc })

    # render({ :template => "messages/index" })
  # end

  # def show
    # the_id = params.fetch("path_id")

    # matching_messages = Message.where({ :id => the_id })

    # @the_message = matching_messages.at(0)

    # render({ :template => "messages/show" })
  # end
