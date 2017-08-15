class User < ActiveRecord::Base
	has_many :beers
	has_many :breweries, :through => :beers

	has_secure_password
end
