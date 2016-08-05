class Admin < ActiveRecord::Base
	has_secure_password
	# Validation
  	
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_presence_of :password, :on => :create
	validates_length_of :password ,{:minimum => 2, :maximum => 255, :on => :create}
	validates_length_of :first_name ,{:minimum => 2, :maximum => 255}
	validates_length_of :last_name ,{:minimum => 2, :maximum => 255}
end
