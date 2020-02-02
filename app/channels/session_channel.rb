class SessionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "session_#{params[:id]}"
  end

  def unsubscribed
  end
end
