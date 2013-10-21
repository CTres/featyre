class User < ActiveRecord::Base
  #Associations
  has_many :features
  has_many :feature_users, dependent: :destroy
  has_many :owned_features, class_name: 'Feature', dependent: :destroy
  accepts_nested_attributes_for :feature_users

  #Validations
  validates_presence_of :username
  validates_uniqueness_of :username

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable
         #:validatable short term fix to turn this off so that self.from_github works
  
  #Attributes
  attr_accessible :feature_users_attributes, :email, :password, :password_confirmation, :remember_me, :username, :name, :company, :collaborator_id
  
  # Methods
  # this is used to add a collaborator, not to sign in a github user through omniauth. that is done below.
  def self.from_github(auth)
    # fix the string to read like omniauth uid
    User.where(uid: auth.id).first_or_create do |user|
      user.provider = 'github'
      user.uid = auth.id
      user.username = auth.login
      user.email = auth.email unless auth.email.nil?
      user.password = Devise.friendly_token[0,20]
      user.name = auth.name
      user.location = auth.location
      user.hireable = auth.hireable
      user.blog = auth.blog
      user.company = auth.company
      user.avatar_url = 'https://0.gravatar.com/avatar/' + "#{auth.gravatar_id}"
      user.gravatar_id = auth.gravatar_id
      #details on the user 
    end
  end

  def self.from_email(email)
    @user = User.where(email: email).first_or_create do |user|
      user.email = email
      user.password = Devise.friendly_token[0,20]
      user.username = email
      user.name = 'invited' if user.name.nil?
    end
    if @user.persisted?
      @user
    else
      puts 'not saved'
    end
  end
  #all omniauth signups go here. 
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.name = auth.extra.raw_info.name
      user.url = auth.extra.raw_info.html_url
      user.location = auth.extra.raw_info.location
      user.hireable = auth.extra.raw_info.hireable
      user.blog = auth.info.urls.blog
      user.company = auth.extra.raw_info.company
      user.avatar_url = auth.extra.raw_info.avatar_url 
      user.gravatar_id = auth.extra.raw_info.gravatar_id
    end
  end
  
  def self.new_with_session(params, session)
    puts "we are in the session part"
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
