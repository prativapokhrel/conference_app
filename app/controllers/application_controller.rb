class ApplicationController < ActionController::Base
  # include UserConcern
  def current_user
    user       = User.new
    salt        = BCrypt::Engine.generate_salt
    user.email = "user+#{salt}@example.com"
    user
  end
end
