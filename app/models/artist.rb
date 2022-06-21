class Artist < ApplicationRecord
  searchkick
  
  has_many :albums
  has_many :tracks

  def search_data
    {
      name_kr: name_kr,
      name_eng: name_eng
    }
  end
end
