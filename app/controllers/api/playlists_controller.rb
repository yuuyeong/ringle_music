class PlaylistsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_playlist_creator
  before_action :validate_playlist_creator

  def create
    @playlist = Playlist.new(playlistable_id: @creator.id, playlistable_type: @creator.class.name)

    if @playlist.save
      render json: @playlist, status: :created
    else
      render json: { errors: @playlist.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private

  def set_playlist_creator
    @creator = if params[:type] == 'group'
                  Group.find_by(id: params[:id])
                else
                  current_user
                end

    render json: { message: "존재하지 않는 사용자 또는 그룹입니다." }, status: :bad_request if @creator.nil?
  end

  def validate_playlist_creator
    return if @creator == current_user

    unless @creator.owner == current_user || GroupMembership.exists?(group: @creator, user: current_user)
      render json: { message: "권한이 없습니다." }, status: :forbidden
    end
  end
end
