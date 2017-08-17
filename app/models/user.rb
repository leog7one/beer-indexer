class User < ActiveRecord::Base
	has_many :beers
	has_many :breweries, :through => :beers
    
    #To enable BCrypt Password
	has_secure_password
end
