require 'dotenv/load'
ENV.fetch("OPENAI_TOKEN")

class MessagesController < ApplicationController
  def index
    matching_messages = Message.all

    @list_of_messages = matching_messages.order({ :created_at => :desc })

    render({ :template => "messages/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_messages = Message.where({ :id => the_id })

    @the_message = matching_messages.at(0)

    render({ :template => "messages/show" })
  end

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

    # Find the system message (assuming one exists per session)
    system_message = Message.find_by(session_id: the_session.id, role: "system")

    # Generate assistant response using OpenAI
    c = OpenAI::Chat.new
    c.system(system_message.content)
    c.user(the_message.content)
    assistant_response = c.assistant!

    # Save assistant message
    assistant_message = Message.new(
      session_id: the_session.id,
      role: "assistant",
      content: assistant_response
    )
    assistant_message.save

    # Get all the older messages for this topic from the db
    
    the_history = the_session.messages.order(:created_at)

    # Reconstruct an AI::Chat from scratch
    reconstructed_chat = OpenAI::Chat.new

    the_history.each do |a_message|
       if a_message.role == "system"
        reconstructed_chat.system(a_message.content)
      elsif a_message.role == "user"
        reconstructed_chat.user(a_message.content)
        else
        reconstructed_chat.assistant(a_message.content)
      end
    end

      # Get the next assistant message

      next_message = Message.new
      next_message.session_id = the_session.id
      next_message.role = "assistant"
      next_message.content = reconstructed_chat.assistant!
      next_message.save

    # Redirect back to the session page
    redirect_to("/sessions/#{the_message.session_id}", { :notice => "Message created successfully." })
  else
    redirect_to("/messages", alert: the_message.errors.full_messages.to_sentence)
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
