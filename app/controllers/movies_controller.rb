class MoviesController < ApplicationController
  def index
    @movies = Movie.order(year: :desc)

    if params[:query].present?
      @movies = @movies.where('title ILIKE ?', "%#{params[:query]}%")
    end

    # check what format was requested and respond with the adequate
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'movies/list', locals: { movies: @movies }, formats: [:html] }
    end
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params) # if the validation failed, the movie stays the same + errors


    respond_to do |format|
      # Default reply from Rails : generate a HTML document (body/head)
      format.html { redirect_to movies_path }
      #  reply with  the partial of the movie updated
      format.text { render partial: "movies/movie_infos", locals: { movie: @movie }, formats: [:html] }
    end
  end


  private

  def movie_params
    params.require(:movie).permit(:title, :year)
  end
end
