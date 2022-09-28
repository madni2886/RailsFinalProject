class Group < ApplicationRecord

  has_many :posts
  has_many :memberships,  dependent: :destroy
  has_many :users, through: :memberships, dependent: :destroy
  has_and_belongs_to_many :users
end
