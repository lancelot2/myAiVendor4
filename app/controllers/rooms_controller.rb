class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @room = @rooms.sort_by {|r| r.messages.last.created_at}.reverse.first
    @no_footer = true
  end

  def update_index
    @room = Room.find(params[:room_id])
    @messages = @room.messages.last(30)
    respond_to do |format|
      format.js
    end
  end

   def show
      @room = Room.find(params[:id])
      p @room.bot
      gon.endpoint = @room.bot.emission_endpoint
      @messages = Message.where(room_id: @room.id)
      @no_footer = true
      @session = Session.where(facebook_id: @room.facebook_id).last
      if @session.status == "blocked"
        @session.update(status: "backer_assigned")
      end
  end
end
