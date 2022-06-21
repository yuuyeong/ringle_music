class Album < ApplicationRecord
  searchkick
  
  belongs_to :artist

  def search_data
    {
      title: title
    }
  end
end
