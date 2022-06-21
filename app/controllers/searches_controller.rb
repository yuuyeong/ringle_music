class SearchesController < ApplicationController
  # before_action :check_params
  
  def index
    

    render json: {msg: 'success'}
  end

  private

  def check_params
    @query = params[:q]
    @sort = params[:sort]
    @limit = params[:limit] || 10
    @offset = params[:offset] || 0
    

  end
end
