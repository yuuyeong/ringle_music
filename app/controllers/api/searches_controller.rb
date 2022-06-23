class Api::SearchesController < ApplicationController  
  def index
    result = Song.search(search_params)

    render json: { result: result }, status: :ok
  end

  private

  def search_params
    {
      query: params[:q],
      sort: params[:sort],
      limit: params[:limit] || 10,
      offset: params[:offset] || 0
    }
  end
end
