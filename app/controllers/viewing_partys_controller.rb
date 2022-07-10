class ViewingPartysController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @movie = MovieFacade.new.movie_details(params[:movie_id])
    @users = User.all
  end

  def create
    movie = MovieFacade.new.movie_details(params[:movie_id])
    duration = params[:duration].to_i
    host_id = params[:host_id]
    if duration >= movie.runtime
      new_party = ViewingParty.create(party_params)
    else
      flash[:error] = 'Duration can not be shorter than movie runtime'
      redirect_to new_user_movie_viewing_party(host_id, movie.id)
    end

    attendees = params[:usernames]
    attendees.each do |id, checked|
      if checked == "1"
        Attendee.create(viewing_party_id: new_party.id, user_id: id)
      end
    end
    redirect_to user_path(new_party.host_id)
  end

  private

  def party_params
    params.permit(:movie, :date, :start_time, :duration, :host_id)
  end

  def attendee_params
    params.permit(:user_id, :movie_id)
  end
end