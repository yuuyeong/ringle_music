class SongBrowser
  def self.call(*args, &block)
    new(*args, &block).call
  end
  
  def initialize(search_params)
    @query = search_params[:q]
    @sort = search_params[:sort] || ''
    @limit = search_params[:limit] || 10
    @offset = search_params[:offset] || 0
  end

  def call
    return [] if @query.nil?

    search
  end

  def search
    sort = if @sort == 'latest'
              'release_date DESC'
            elsif @sort == 'likes'
              'likes DESC'
            else 
              ''
            end

    Song.select('title', 'artist_kr AS artist', 'album', 'likes')
        .where(
          'artist_kr like ? or artist_eng like ? or title like ? or album like ?',
          "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%"
        )
        .order(sort)
        .offset(@offset)
        .limit(@limit)
  end
end
