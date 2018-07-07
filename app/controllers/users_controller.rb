class UsersController < ApplicationController

	get '/signup' do
  		if logged_in?
  			redirect to '/users/new'
		else
			erb :'/users/login'
		end
  	end

  	post '/signup' do	
  		if params["username"].empty? || params["password"].empty? || params["email"].empty?
  			redirect to '/signup'
  		else
  			user = User.create(username: params["username"], password: params["password"], email: params["email"])
  			session[:user_id] = user.id
  			redirect to '/categories'
  		end

  	end

  	get '/login' do
		if !logged_in?
  			erb :'/users/login'
  		else
  			redirect to '/categories'
  		end
	end

	post '/login' do 
		user = User.find_by(:username => params[:username])
		
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
  			redirect to '/categories'
		end
	end


end
