class PlaylistTracksController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_tracks_count
  before_action :find_playlist
  before_action :validate_playlist_creator

  def create
    @playlist.playlist_tracks.insert_all!(@track_list.map { |track_id| { track_id: track_id } })
    @playlist.realod.check_tracks_limit
    
    render json: { message: "곡이 추가되었습니다." }, status: :created
  rescue => error
    render json: { errors: error }, status: :unprocessable_entity
  end

  def destroy
    @playlist.playlist_tracks.where(track_id:@track_list).delete_all

    render json: { message: "곡이 삭제되었습니다." }, status: :ok
  rescue => error
    render json: { errors: error }, status: :unprocessable_entity
  end

  private

  def find_playlist
    @playlist = Playlist.find_by(id: params[:id])

    render json: { message: "존재하지 않는 플레이리스트입니다." }, status: :bad_request if @playlist.nil?
  end

  def validate_playlist_creator
    if @playlist.playlistable.is_a?(Group)
      unless @playlist.owner == current_user || GroupMembership.exists?(group: @creator, user: current_user)
        render json: { message: "권한이 없습니다." }, status: :forbidden
      end
    else
      unless @playlist.playlistable == current_user
        render json: { message: "권한이 없습니다." }, status: :forbidden
      end
    end
  end

  def validate_tracks_count
    @track_list = params[:track_ids].gsub(/[\s]/ ,"").split(',')

    render json: { message: "100곡이 넘습니다." }, status: :bad_request if @track_list.length > 100
  end
end
