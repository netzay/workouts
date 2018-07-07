class CategoriesController < ApplicationController

	get '/categories' do 
		if logged_in? 
			@categories = Category.all
			erb :'/categories/index'
		else
			redirect to '/login'
		end
	end
	

	
end

