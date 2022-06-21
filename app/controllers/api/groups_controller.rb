class Api::GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  # show current_users groups
  def index
  end

  def create
    @group = Group.new(group_params.merge(owner: current_user))

    if @group.save
      render json: @group, status: :created
    else
      render json: { errors: @group.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
	end

	private

	def group_params
    params.require(:group).permit(:name)
  end
end
