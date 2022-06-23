class Api::PlaylistTracksController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_tracks_count, only: [:create, :destroy]
  before_action :find_playlist
  before_action :validate_playlist_creator

  def index
    track_list = @playlist.track_list

    render json: { result: track_list }, status: :ok
  end

  def create
    @playlist.playlist_tracks.insert_all!(@track_list.map { |track_id| { track_id: track_id } })
    @playlist.reload.check_tracks_limit
    
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

  def validate_tracks_count
    @track_list = playlist_track_params[:track_ids].to_s.gsub(/[\s]/ ,"").split(',')

    render json: { message: "100곡이 넘습니다." }, status: :bad_request if @track_list.length > 100
  end

  def validate_playlist_creator
    render json: { message: "권한이 없습니다." }, status: :forbidden unless is_creator_authorized?
  end

  def is_creator_authorized?
    if @playlist.playlistable.is_a?(Group)
      @playlist.playlistable.check_authorization(current_user)
    else
      @playlist.playlistable == current_user
    end
  end

  def playlist_track_params
    params.require(:playlist_track).permit(:track_ids)
  end
end
