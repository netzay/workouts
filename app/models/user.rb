class User < ActiveRecord::Base
	has_many :categories
	has_secure_password

	def self.valid_entry(params)
		return ![:username].empty? && ![:password].empty?
	end

end
