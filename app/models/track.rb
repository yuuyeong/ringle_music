class Track < ApplicationRecord
  searchkick
  
  belongs_to :artist
  belongs_to :album
end
