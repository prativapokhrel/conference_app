class Room < ApplicationRecord 

  #validations
  validates :name, presence: true 
end 