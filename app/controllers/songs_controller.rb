class SongsController < ApplicationController

  def index
    if params[:artist_id] # if artist involved
      @artist = Artist.find_by_id(params[:artist_id]) # find by artist id
      if @artist.nil? # if artist id nil
        flash[:alert] = "Artist not found." # flash mess. was not found
        redirect_to artists_path  # redirect to artists index
      else 
        @songs = @artist.songs # if not nil, songs eq artist.songs
      end
    else # if no artist involved
      @songs = Song.all # show all songs, no matter the artist
    end
  end

  def show
    if params[:artist_id] # if artist involved
      @artist = Artist.find_by(params[:artist_id]) # find artist by id
      @song = @artist.songs.find_by_id(params[:id]) # set song to associated artist
      if @song.nil? # BUT if sond is emplty
        flash[:alert] = "Song not found." # flash mess. no song
        redirect_to artist_songs_path(@artist) # rediredt # artists songs
      end
    else # if no artist involved 
      @song = Song.find(params[:id]) # find single song by id
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

