class Novelist < ActiveRecord::Base
	#attr_accessible :name, :gender, :date_of_birth, :nationality
	has_many :novels
end