class WorkoutsController < ApplicationController

	get '/workouts/:id' do
		if session[:user_id]
    		@workout = Workout.find(params[:id])
    		@workout.save
			erb :'/workouts/edit'

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
			erb :'/workout/show'
		end
  	end

	get '/workouts/:id/edit' do
		if session[:user_id]
    		@workout = Workout.find(params[:id])
    		@category = Category.find(params[:id])
    		@workout.category.save
			erb :'/categories/show'

		else
			redirect to '/login'
  		end
  	end

  	delete '/workouts/:id/delete' do
		if session[:user_id]
    		@workout = Workout.find_by_id(params[:id])
    		@workout.delete
    		erb :'/categories/show'
    	end
    end
end