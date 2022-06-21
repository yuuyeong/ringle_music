class Track < ApplicationRecord
  searchkick
  
  belongs_to :artist
  belongs_to :album

  def search_data
    {
      title: title
    }
  end
end
