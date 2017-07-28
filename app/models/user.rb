class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  has_many :ratings
  has_many :recipes
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        #  user.image = auth.info.image # assuming the user model has an image
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
      end
    end

    def feed
      following_ids = "SELECT followed_id FROM relationships
                       WHERE  follower_id = :user_id"
      Recipe.where("user_id IN (#{following_ids})
                       OR user_id = :user_id", user_id: id)
    end


    # Follows a user.
   def follow(other_user)
     following << other_user
   end

   # Unfollows a user.
   def unfollow(other_user)
     following.delete(other_user)
   end

   # Returns true if the current user is following the other user.
   def following?(other_user)
     following.include?(other_user)
   end

end
