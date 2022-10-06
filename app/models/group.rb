class Group < ApplicationRecord

  has_many :posts
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships, dependent: :destroy
  has_and_belongs_to_many :users
  has_one_attached :image
  has_many_attached :pictures
  has_rich_text :body

end
