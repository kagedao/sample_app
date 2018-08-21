class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :reverse_relationships, foregin_key: "follower_id",
                                   class_name: :"Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def feed
    Micropost.where("user_id = ?", id)
  end
  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  #validates :name, presence: true, length: { maximum: 50 }
  
  
end
