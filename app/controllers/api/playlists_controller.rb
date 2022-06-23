class Api::PlaylistsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_playlist_creator
  before_action :validate_playlist_creator
  
  def create
    @playlist = Playlist.new(playlistable: @creator, name: playlist_params[:name])

    if @playlist.save
      render json: @playlist, status: :created
    else
      render json: { errors: @playlist.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private

  def check_playlist_creator
    @creator = if playlist_params[:type] == 'group'
                  Group.find_by(id: playlist_params[:type_id])
                else
                  User.find_by(id: playlist_params[:type_id])
                end

    render json: { message: "존재하지 않는 사용자 또는 그룹입니다." }, status: :bad_request if @creator.nil?
  end

  def validate_playlist_creator
    render json: { message: "권한이 없습니다." }, status: :forbidden unless is_creator_authorized?
  end

  def playlist_params
    params.require(:playlist).permit(:type, :type_id, :name)
  end

  def is_creator_authorized?
    if playlist_params[:type] == 'group'
      @creator.check_authorization(current_user)
    else
      @creator == current_user
    end
  end
end
