class UsersController < ApplicationController

	 get '/users/:id' do
    if !session[:user_id]
      redirect '/login'
    end
  end

  get '/signup' do
    if !session[:user_id]
      erb :'/users/new'
    else
      redirect to '/workouts/new'
    end
  end

  post '/signup' do	
  	if params[:username].empty? || params[:password].empty? 
  		redirect to '/signup'
  	else
  		@user = User.create(username: params[:username], password: params[:password])
  		session[:user_id] = @user.id
  		redirect to '/workouts/new'
  	end
  end
  
  get '/login' do
    if !session[:user_id]
      erb :'/users/login'
    else
      redirect to '/workouts/new'
    end
  end
  
  post '/login' do
    @user = User.find_by(:username => params[:username])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      current_user = session[:user_id]
        redirect to '/workouts/new'
    else
      redirect to '/login'
    end
  end
  
  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
