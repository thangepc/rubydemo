class User < ActiveRecord::Base
	before_save :beforeSave
	has_secure_password

	# RelationShip
	has_many :comments
	
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_presence_of :password, :on => :create
	validates_length_of :password ,{:minimum => 2, :maximum => 255, :on => :create}
	validates_length_of :first_name ,{:minimum => 2, :maximum => 255}
	validates_length_of :last_name ,{:minimum => 2, :maximum => 255}

	def self.authenticate(email, password)
		user = self.find_by_email(email)
		# render :json => user
		# return
	    if user && user.password_digest == BCrypt::Engine.hash_secret(password, user.password_digest) && user.status == 1
	      user
	    else
	      nil
	    end
	end

	def beforeSave
		self.status = 1
	end

	# Facebook
	def self.from_omniauth(auth)
		user = self.where('provider = ? AND uid = ?', auth.provider, auth.uid).first
		if user.nil?
			user = User.new(provider: auth.provider, uid: auth.uid, name: auth.info.name, oauth_token: auth.credentials.token, oauth_expires_at: Time.at(auth.credentials.expires_at))
      user.save!(:validate => false)
		end
    user
  end
end
