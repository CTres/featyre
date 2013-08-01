class Github
	#Methods
	def initialize(token)
		@client = Octokit::Client.new(login: "me", oauth_token: token)
	end

	def username_exists(username)
		@client.user(username)
	end

	def find_by_name(name)
		@client.search_users(name)
	end

	def all_users()
		@client.all_users()
	end


	def create_user_from_username(hash = {})
		#throw it through the omniauth 
		user = User.from_github(hash)
		if user.persisted?
			puts 'saved'
			else
			puts 'not saved'
		end
	end
end