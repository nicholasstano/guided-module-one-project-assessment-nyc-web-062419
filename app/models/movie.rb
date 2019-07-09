class Movie < ActiveRecord::Base
	belongs_to :car
	belongs_to :actor
end
