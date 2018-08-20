class CategoriesController < ApplicationController

	get '/categories' do 
		if logged_in? 
			@categories = Category.all
			erb :'/categories/index'
		else
			redirect to '/login'
		end
	end

 	post '/categories' do 
   		@category = Category.create(params[:category])
		if Workout.valid_entry?(params)
    		@category.workouts << Workout.create(title: params[:workout][:title], link: params[:workout][:link])
    	end
    		@category.save
    		redirect to "categories/#{@category.id}"
    	end	

	get '/categories/index' do
		if session[:user_id]
		  @categories = Category.all
		  erb :'/categories/index'
	   end
	end

	get '/categories/new' do
		if logged_in?
			@workouts = Workout.all 
			erb :'/categories/new'
		else
			redirect to '/login'
		end
	end

	get '/categories/:id' do
		@user = current_user
		if logged_in?
    		@category = Category.find(params[:id])
    		@workout = Workout.find_by(params[:id])	
		    erb :'/categories/show'
  		end
  	end

  	post '/categories/:id' do
  		@category = Category.find(params[:id])
  		@category.update(params[:category])
  			if Workout.valid_entry?(params)
  				@category.workouts << Workout.create(title: params[:workout][:title], link: params[:link][:title])
  			else
  				redirect to "/categories/#{@category.id}/edit?error=invalid entry"
  			end
    		redirect to '/categories/index'
    	end
    

  
  	 delete '/categories/:id' do
		if logged_in?
    		@category = Category.delete(params[:id])
			redirect to '/categories/index'
    	end
    end
	
end