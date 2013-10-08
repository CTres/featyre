class Github
	#Methods
	def initialize(token)
		@client = Octokit::Client.new(login: "me", oauth_token: token)
	end

	def find_by_username(username)
		client = @client.user(username)
	end

	def find_by_name(name)
		@client.search_users(name)
	end

	def find_by_email(email)
		client= @client.user(email)
	end

	def all_users()
		@client.all_users()
	end

	def create_user_by_username(hash = {})
		user = User.from_github(hash)
		if user.persisted?
			user
		else
			puts 'not saved'
		end
	end
end