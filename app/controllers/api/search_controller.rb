class Api::SearchController < ApplicationController  
  def index
    result = SongBrowser.call(params)

    render json: { result: result }, status: :ok
  end
end
