class MoviesController < ApplicationController

    get '/movies/' do
      redirect_if_not_logged_in
      @movies = Movie.all
      erb :'movies/index'
    end
  
    get '/movies/new' do
      redirect_if_not_logged_in
      erb :'movies/new'
    end
  
    post '/movie' do
      redirect_if_not_logged_in
      movie = Movie.create(params[:movie])
      user = current_user
      user.movies << movie
      redirect "movies/#{movie.id}"
    end
  
  
    get '/movies/:id' do
      redirect_if_not_logged_in
      @movie = Movie.find_by(id: params[:id])
      if !@movie
        redirect '/movies'
      end
      erb :'movies/show'
    end
  
  
    get '/movies/:id/edit' do
      redirect_if_not_logged_in
      @movie = Movie.find_by(id: params[:id])
      if !check_owner(@movie)
        redirect '/movies'
      end
      erb :'movies/edit'
    end
  
    patch '/movies/:id' do
      redirect_if_not_logged_in
      @movie = Movie.find_by(id: params[:id])
      if check_owner(@movie)
        @movie.update(params[:movie])    
      end  
      erb :'movies/show'
    end
  
    delete '/movies/:id' do
      redirect_if_not_logged_in
      movie = Movie.find_by(id: params[:id])
      if check_owner(@movie)
        @movie.delete
        redirect('/movies')
      else
        erb :'movies/show'
      end
    end
  
  
  end
  