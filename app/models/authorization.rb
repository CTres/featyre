class Authorization < ActiveRecord::Base
# Associations
belongs_to :user
# attr_accessible :title, :body

  def fetch_details(auth)
    self.send("fetch_details_from_#{self.provider.downcase}",auth)
  end


  # def fetch_details_from_facebook
  #         graph = Koala::Facebook::API.new(self.token)
  #         facebook_data = graph.get_object("me")
  #         self.username = facebook_data['username']
  #         self.save
  #         self.user.username = facebook_data['username'] if self.user.username.blank?
  #         self.user.remote_image_url = "http://graph.facebook.com/" + self.username + "/picture?type=large" if self.user.image.blank?
  #         self.user.location = facebook_data['location'] if self.user.location.blank?
  #         self.user.save
  # end

  # def fetch_details_from_twitter
  #         twitter_object = Twitter::Client.new(
  #                 :oauth_token => self.token,
  #                 :oauth_token_secret => self.secret
  #                 )
  #         twitter_data = Twitter.user(self.uid.to_i)
  #         self.username = twitter_data.username
  #         self.save
  #         self.user.username = twitter_data.username if self.user.username.blank?
  #         self.user.remote_image_url = twitter_data.profile_image_url if self.user.image.blank?
  #         self.user.location = twitter_data.location if self.user.location.blank?
  #         self.user.save(:validate => false)
  # end


  def fetch_details_from_github(auth)
    self.user.name = auth.extra.raw_info.name
    self.user.url = auth.extra.raw_info.html_url
    self.user.location = auth.extra.raw_info.location
    self.user.hireable = auth.extra.raw_info.hireable
    self.user.blog = auth.info.urls.blog
    self.user.company = auth.extra.raw_info.company
    self.user.avatar_url = auth.extra.raw_info.avatar_url 
    self.user.gravatar_id = auth.extra.raw_info.gravatar_id
    self.user.save
  end


  def fetch_details_from_linkedin

  end

  def fetch_details_from_google_oauth2(auth)
    self.user.avatar_url = auth.info.image
    self.user.save
  end
end



