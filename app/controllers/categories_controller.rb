class CategoriesController < ApplicationController

	get '/categories' do 
		if logged_in? 
			@categories = Category.all
			erb :'/categories/index'
		else
			redirect to '/login'
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

	post '/categories' do
		@category = Category.create(params[:category])
		if !params[:workout][:title].empty?
			@category.workouts << Workout.create(title: params[:workout][:title], link: params[:workout][:link])
		end
		@category.save
		redirect to "/categories/#{@category.id}"
	end

	get '/categories/index' do
		if session[:user_id]
		@categories = Category.all
		erb :'/categories/index'
	end

	end

	get '/categories/:id' do
		if session[:user_id]
    	@category = Category.find_by_id(params[:id])
    	erb :'/categories/show'
  	end
  end
  get '/category/:id' do
		if session[:user_id]
    	@category = Category.find_by_id(params[:id])
    	erb :'/categories/show'
  	end
  end
  
	
	

	
end

