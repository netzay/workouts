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
   		if !params[:workout][:title].empty? && !params[:workout][:link].empty?
    		@category.workoutss << Workout.create(title: params[:workout][:title], link: params[:workout][:link])
    	end
    		@category.save
    		redirect to "categories/#{@category.id}"
  	end


 	post '/categories' do 
   			@category = Category.create(params[:category])
   		if !params[:workout][:title].empty? && !params[:workout][:link].empty?
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
		if session[:user_id]
    		@category = Category.find(params[:id])
	    	erb :'/categories/show'
  		end
  	end

  	post '/categories/:id' do
  		@category = Category.find(params[:id])
  		@category.update(params[:category])
  		if !params[:workout][:title].empty?
  			@category.workouts << Workout.create(title: params[:workout][:title])
  		end
    	redirect to '/categories#{@category.id}'
    end
    

  
  	delete '/categories/:id' do
		if session[:user_id]
    		@category = Category.delete(params[:id])
			redirect to '/'
    	end
    end

	
end

