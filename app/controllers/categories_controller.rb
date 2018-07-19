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

	post '/category' do
		@category = Category.create(params[:category])
		if !params[:workout][:title].empty?
			@category.workouts << Workout.create(title: params[:workout][:title])
		end
		@category.save
		redirect to "categories/#{category.id}"
	end

	get '/categories/:id' do
		@category = Category.find(params[:id])
		erb :'/categories/show'
	end


	

	
end

