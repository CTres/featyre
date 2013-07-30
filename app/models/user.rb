class User < ActiveRecord::Base
  #Associations
  has_many :owned_features, class_name: 'Feature', foreign_key: :user_id, dependent: :destroy
  has_many :feature_users
  has_many :collaborated_features, through: :feature_users

  #Validations
  validates_presence_of :username
  validates_uniqueness_of :username

  #Attributes
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :collaborator_id

  #Scopes
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Methods
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.email = auth.info.email
    end
  end
  
  def self.new_with_session(params, session)
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
