class Group < ApplicationRecord
  validates :title, presence: true

  has_many :posts
  has_many :group_user_relationships
  has_many :members, through: :group_user_relationships, source: :user

  belongs_to :user
end
