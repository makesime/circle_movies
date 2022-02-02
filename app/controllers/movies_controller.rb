class MoviesController < ApplicationController
  require 'rest-client'

  def search
    return {} unless search_params[:query].present?

    response = RestClient.get 'https://api.themoviedb.org/3/search/movie?api_key=a99cc60fc2b34dbb18cb806b8a88ed14', { params: { query: search_params[:query]}}

    render json: response
  end

  def search_params
    params.permit(:query)
  end
end