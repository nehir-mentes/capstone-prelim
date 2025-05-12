class SessionsController < ApplicationController
  def index
    matching_sessions = Session.all

    @list_of_sessions = matching_sessions.order({ :created_at => :desc })

    render({ :template => "sessions/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_sessions = Session.where({ :id => the_id })

    @the_session = matching_sessions.at(0)

    render({ :template => "sessions/show" })
  end

  def create
    the_session = Session.new
    the_session.title = params.fetch("query_title")
    the_session.restaurant = params.fetch("query_restaurant")
    the_session.owner = params.fetch("query_owner")

    if the_session.valid?
      the_session.save
      redirect_to("/sessions", { :notice => "Session created successfully." })
    else
      redirect_to("/sessions", { :alert => the_session.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_session = Session.where({ :id => the_id }).at(0)

    the_session.title = params.fetch("query_title")
    the_session.restaurant = params.fetch("query_restaurant")
    the_session.owner = params.fetch("query_owner")

    if the_session.valid?
      the_session.save
      redirect_to("/sessions/#{the_session.id}", { :notice => "Session updated successfully."} )
    else
      redirect_to("/sessions/#{the_session.id}", { :alert => the_session.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_session = Session.where({ :id => the_id }).at(0)

    the_session.destroy

    redirect_to("/sessions", { :notice => "Session deleted successfully."} )
  end
end
