class Api::GroupMembershipsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_group, only: [:create]
  before_action :check_if_user_is_owner_or_member, only: [:create]
  
  def create
    @group_membership = GroupMembership.new(group: @group, user: @user )

    if @group_membership.save
      render json: @group_membership, status: :created
    else
p
      render json: { errors: @group_membership.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private

  def find_group
    @group = Group.find_by(id: params[:group_id])

    render json: { message: "존재하지 않는 그룹입니다." }, status: :bad_request if @group.nil?
  end

  def check_if_user_is_owner_or_member
    @user = User.find(group_memberships_params[:user_id])

    if @group.owner == @user || GroupMembership.exists?(group: @group, user: @user)
      render json: { message: "이미 그룹에 존재하는 사용자입니다." }, status: :unprocessable_entity
    end
  end

  def group_memberships_params
    params.require(:group_membership).permit(:user_id)
  end
end
