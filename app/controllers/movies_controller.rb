class MoviesController < ApplicationController
  def index
  		@movies = Movie.all
  end

  def new
  	@movie = Movie.new
  end

  def create
  	@movie = Movie.new(params[:movie])
  	Movie.transaction do
  		@movie.save!
  	end
  	redirect_to movies_path
  end

end
