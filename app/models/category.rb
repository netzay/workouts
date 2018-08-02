class Category < ActiveRecord::Base
	belongs_to :user
	has_many :workouts

	def self.valid_entry(params)
		return !params[:category][:title].empty? 
	end
end
