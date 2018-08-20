class Workout < ActiveRecord::Base
	belongs_to :user
	belongs_to :category

	def self.valid_entry(params)
		return !params[:workout][:title].empty? && !params[:workout][:link].empty? 
	end
end
