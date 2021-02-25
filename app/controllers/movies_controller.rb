class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # most basic
      # @movies = Movie.where(title: params[:query])

      # less basic
      # @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")

      # multi column
      # sql_query = "title ILIKE :query OR synopsis ILIKE :query"
      # @movies = Movie.where(sql_query, query: "%#{params[:query]}%")

      # multi table
      # sql_query = " \
      #   movies.title ILIKE :query \
      #   OR movies.synopsis ILIKE :query \
      #   OR directors.first_name ILIKE :query \
      #   OR directors.last_name ILIKE :query \
      # "
      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      # using @@ for multiple query matches
      # sql_query = " \
      #   movies.title @@ :query \
      #   OR movies.synopsis @@ :query \
      #   OR directors.first_name @@ :query \
      #   OR directors.last_name @@ :query \
      # "
      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      # PG one model search
      # @movies = Movie.search_by_title_and_synopsis(params[:query])

      # PG associated search
      # @movies = Movie.global_search(params[:query])

      # PG MULTISEARCH
      # @results = PgSearch.multisearch(params[:query])

      # ELASTIC SEARCH
      @results = Movie.search(params[:query])

    else
      @movies = Movie.all
    end
  end
end
