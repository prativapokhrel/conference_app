class SessionsController < ApplicationController
  def create
    head :no_content
    ActionCable.server.broadcast "session_#{params[:roomName]}", params
  end
end
