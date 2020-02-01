require 'rest-client'
require 'json'

class RoomsController < ApplicationController

  skip_before_action :verify_authenticity_token
  # before_action :set_user
  # before_action :set_room,           only: %i[show]
  # rescue_from ActiveRecord::RecordNotFound, with: :room_not_found
  rescue_from SocketError, with: :socket_error

  # def authenticate
  #   password_hash = @room.check_hashed_password(@room.password)

  #   if password_hash == params[:password]
  #     flash[:success] = "You are now in the room: #{@room.name}"
  #     redirect_to action: 'show', password: password_hash
  #   else
  #     flash[:notice] = 'You entered the incorrect password!'
  #   end
  # end


  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    
    respond_to do |format|
      if @room.save
        format.html do
          flash[:success] = 'You created a room!'
          redirect_to room_path(@room.id)
        end

        format.json { render json: @room, status: :created}
      else
        format.html do
          flash[:notice] = 'Sorry, that room is taken!'
          redirect_to root_path
        end

        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @room = Room.find_by_name(params[:id])
    @user = current_user
    # XirsysCredentialsJob.perform_later(@room.name)
  end


  private

  def set_user
    @user = current_user
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name)
  end

  def room_not_found
    flash[:notice] = 'That room does not exist, would you like to create it?'
    redirect_to new_room_path
  end

  def socket_error
    flash[:notice] = 'TODO: Something went wrong with the WebRTC stuff'
    redirect_to root_path
  end
end
