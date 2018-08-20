class WorkoutsController < ApplicationController

  get '/workouts' do
    @workouts = Workout.all
    erb :'/workouts/show'
  end

  get '/workouts/new' do
  if logged_in?
      @categories = Category.all 
      erb :'/workouts/new'
    else
      redirect to '/login'
    end
  end

 post '/workouts' do 
      @user = current_user
     if logged_in? && Category.valid_entry(params)
        @workout = Workout.create(params[:workout])
        @workout.category = Category.create(title: params[:category][:title])
        @user.workouts << @workout
        redirect to "/workouts/#{@workout.id}"
    else
      redirect "/login"
    end
  end

  
  get '/workouts/:id' do
      @user = current_user
      @workout = Workout.find(params[:id])
    if session[:user_id] == @workout.user_id
       erb :'/workouts/show'
    else
      redirect to '/login'
    end
  end
  
  post '/workouts/:id' do 
      @user = current_user
      @workout = Workout.find(params[:id])
    if session[:user_id] == @workout.user_id 
      @workout.update(params[:workout])
    end
    @workout.save
    redirect to "/workouts/#{@workout.id}"
  end


  patch '/workouts/:id' do
    @workout = Workout.find_by_id(params[:id])
    if session[:user_id] == @workout.user_id 
      @user = current_user
      @workout.update(title: params[:title], link: params[:link])
      @workout.save
      redirect "/workouts/#{@workout.id}"
    else
      redirect "/workouts/#{workout.id}/edit"
    end
  end

  get '/workouts/:id/edit' do
    if logged_in?
      @user = current_user
      @workout = Workout.find_by_id(params[:id])
      if session[:user_id] == @workout.user_id
        erb :'/workouts/edit'
      else
        redirect to '/categories'
      end
    else
      redirect '/login'
    end
  end

  delete '/workouts/:id/delete' do
    @user = current_user
    @workout = Workout.find_by_id(params[:id])
    if session[:user_id] == @workout.user_id
      @workout.delete
      #@workout = Workout.delete(params[:id])
      redirect to '/categories/index'
    else
      redirect "/workouts/#{@workout.id}"
      end
    end
end
