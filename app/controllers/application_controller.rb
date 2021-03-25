class ApplicationController < Sinatra::Base

    configure do
      set(:views, 'app/views')
      set :public_folder, 'public'
      enable :sessions
      set :session_secret, 'stillz'
    end
  
    get('/') do
      redirect '/home'
    end
  
    get '/home' do
      erb:home
    end
    
    helpers do

      def current_user
        User.find_by(id: session[:user_id])
      end

      def redirect_if_not_logged_in
        redirect '/login' unless current_user
      end

      def check_owner(obj)
        ob && obj.user == current_user
      end

    end
  
  
  end
  