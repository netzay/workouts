require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "workout_organizer"
  end

  helpers do 
     #  methods go in here that will be utilized thorughout other controllers
     # set current user, checking if user is logged in
     # logged in - checked for user logged in
     # ? at the end of method name - returns t-any truthy or falsey value (example nil=false) truthy = array, not falsey (boolean -t/f)
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find_by(session[:user_id])
  end

  def redirect_if_not_logged_in
    if !logged_in? 
      redirect '/login'
    end
  end

  get '/' do
    erb :'index'
  end
  
  end
end
