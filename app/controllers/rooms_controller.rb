require 'json'

class RoomsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    
    respond_to do |format|
      if @room.save
        format.html do
          flash[:success] = 'You created a room!'
          redirect_to room_path(@room.name)
        end

        format.json { render json: @room, status: :created}
      else
        format.html do
          flash[:notice] = 'Sorry, something went wrong'
          redirect_to root_path
        end

        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @room = Room.find_by_name(params[:id])
    unless @room.present?
      flash[:error] = 'The room does not exist, would you like to create one?'
      redirect_to root_path
    end 
    @user = current_user
  end


  private

  def room_params
    params.require(:room).permit(:name)
  end
end
