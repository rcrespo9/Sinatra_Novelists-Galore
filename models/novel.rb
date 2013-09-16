class Novel < ActiveRecord::Base
	# attr_accessible :name
	belongs_to :novelist
end