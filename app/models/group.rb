class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :group_memberships
  has_many :members, through: :group_memberships, source: :user
  has_one :playlist, as: :playlistable

  validates :name, :owner_id, presence: true

  def check_authorization user
    has_owner?(user) || has_member?(user)
  end
  
  private

  def has_owner? user
    owner == user
  end

  def has_member? user
    GroupMembership.exists?(group: self, user: user)
  end
end
