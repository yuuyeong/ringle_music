class Playlist < ApplicationRecord
  MAX_TRACKS_IN_LIST = 5

  belongs_to :playlistable, polymorphic: true

  has_many :playlist_tracks, before_add: :check_tracks_limit
  has_many :songs, through: :playlist_tracks, source: :track

  validates :playlistable_id, uniqueness: { scope: :playlistable_type }
  validates :name, :playlistable_id, :playlistable_type, presence: true

  def check_tracks_limit
    track_list_length = playlist_tracks.size

    playlist_tracks.order(created_at: :asc)
      .limit(track_list_length - MAX_TRACKS_IN_LIST)
      .delete_all if track_list_length > MAX_TRACKS_IN_LIST
  end
end
