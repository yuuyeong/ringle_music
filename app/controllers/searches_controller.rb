class SearchesController < ApplicationController
  before_action :check_params
  
  def index
    puts @query
    puts @sort
    puts @limit
    puts @offset
    puts @search_type
    render json: {msg: 'success'}
  end

  private

  def check_params
    @query = params[:q]
    @sort = params[:sort]
    @limit = params[:limit] || 10
    @offset = params[:offset] || 0
    # type : song artist album
    @search_type = params[:type]
    

  end
end
