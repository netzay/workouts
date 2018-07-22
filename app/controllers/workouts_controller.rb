class WorkoutsController < ApplicationController

	get 'workouts' do
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
    	@workout = Workout.create(params[:workout])
    	if !params[:category][:title].empty?
      		@workout.category = Category.create(title: params[:category][:title])
    	end
    		@workout.save
			redirect to "/workouts/#{@workout.id}"
  		end
  

  post '/workouts/:id' do 
    @workout = Workout.find(params[:id])
    @workout.update(params[:workout])
    if !params[:category][:title].empty?
      @workout.category = Category.create(title: params[:category][:title])
    end
    @workout.save
    redirect to "/workouts/#{@workout.id}"
  end


	get '/workouts/:id' do
		if session[:user_id]
    		@workout = Workout.find(params[:id])
			erb :'/workouts/show'

		else
			redirect to '/login'
  		end
  	end


  patch '/workouts/:id' do
		if session[:user_id]
  			redirect to "/workouts/#{params[:id]}/edit"
  		else
    		@workout = Workout.find_by_id(params[:id])
    		@workout.save
			erb :'/workouts/show'
		end
  end

	get '/workouts/:id/edit' do
		if session[:user_id]
    		@workout = Workout.find(params[:id])
			erb :'/workouts/edit'
		else
			redirect to '/login'
  		end
  	end

  	delete '/workouts/:id' do
		if session[:user_id]
    	@workout = Workout.delete(params[:id])
      redirect to '/'
    	end
    end
end

