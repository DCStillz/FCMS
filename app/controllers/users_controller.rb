class UsersController < ApplicationController

    get '/signup' do
        if session[:user_id]
            redirect "/users/#{session[:user_id]}"
        end
        erb :'users/signup'
    end

    post '/signup' do
        u = User.create(username: params[:username], password: params[:password])
        if u.id
        session[:user_id] = u.id
        redirect "/users/#{u.id}"
        else
            erb :'/users/signup' 
        end
    end

    get '/users/:id' do
        redirect_if_not_logged_in
        @user = User.find_by(id: params[:id])
        @movies = @user.movies
        erb :'users/show'
    end

    get '/login' do
        if session[:user_id]
            redirect "/users/#{session[:user_id]}"
        end
        erb :'users/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            erb :'users/login'
        end
    end

    get '/logout' do 
        session.clear
        redirect '/login'
    end

    get '/users' do
        redirect_if_not_logged_in
        @users = User.all
        erb :'users/index'
    end

end
