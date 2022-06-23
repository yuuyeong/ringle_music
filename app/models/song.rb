class Song < ApplicationRecord
  def search(conditions)
    sort = if conditions[:sort] == 'latest'
              'release_date DESC'
            elsif conditions[:sort] == 'likes'
              'likes DESC'
            else 
              ''
            end

    Song.select('title', 'artist_kr', 'album', 'likes')
        .where('artist_kr like ? or artist_eng like ? or title like ? or album like ?', "#{query}", "#{query}", "#{query}", "#{query}")
        .order(sort)
        .offset(conditions[:offset])
        .limit(conditions[:limit])
  end
end
