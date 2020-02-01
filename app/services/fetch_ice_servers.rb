# require 'rest-client'
# require 'json'

# # Get ICE STUN and TURN list
# class FetchIceServers
#   def initialize(room_id)
#     @room_id = room_id
#   end

#   def run
#     broadcast_list(ice_server_list)
#   end

#   def ice_server_list
#     ice = { iceServers: [{ urls: 'stun:stun.l.google.com:19302' }, { urls: 'turn:13.250.13.83:3478?transport=udp', credential: 'YzYNCouZM1mhqhmseWk6', username: 'YzYNCouZM1mhqhmseWk6' }] }
#     response = RestClient.put ice, accept: :json

#   end

#   def broadcast_list(response)
#     ActionCable.server.broadcast "ice_#{@room_id}", response
#   end
# end
