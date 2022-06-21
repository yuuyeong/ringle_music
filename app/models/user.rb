class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  has_many :owned_groups, foreign_key: "owner_id", class_name: "Group"
  has_many :groups, through: :group_memberships
  has_many :group_memberships
  
  validates :email, :password, :name, presence: true, :on => :create
end
