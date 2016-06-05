class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
         
  has_many :blogs, dependent: :destroy
  has_many :comments
  has_many :questions, dependent: :destroy

  mount_uploader :image, ImageUploader
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil) 
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user 
      user = User.create(name: auth.extra.raw_info.name, provider: auth.provider, uid: auth.uid, email: User.create_unique_email, password: Devise.friendly_token[0,20]) 
    end 
    user
  end
  
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil) 
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user 
      user = User.create(name: auth.info.nickname, provider: auth.provider, uid: auth.uid, email: User.create_unique_email, profile_image_url: auth[:extra][:raw_info][:profile_image_url], password: Devise.friendly_token[0,20]) 
    end 
    user
  end
  
  def self.create_unique_string 
    SecureRandom.uuid 
  end
  
  def self.create_unique_email 
    User.create_unique_string + "@example.com" 
  end
  
  def update_without_current_password(params, *options)
    params.delete(:current_password)
 
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
 
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end


end
