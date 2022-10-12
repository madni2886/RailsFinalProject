class Group < ApplicationRecord

  has_many :posts
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships, dependent: :destroy
  has_and_belongs_to_many :users
  has_one_attached :image
  has_many_attached :pictures
  validates :title, :group_type, :image, presence: true
  has_rich_text :body

  public

  def check_request_status(currU)
    group = memberships.where(user_id: currU.id)
    if group[0] == nil
      userid = -1
      req    = false
    else
      userid = group[0].user_id
      req    = group[0].req
    end
  end

  def check_group_admin(currU)
    x = users
    x[0].id == currU.id
  end

  def generate_url(currU)

    @url = "[::1]:3000//user/#{currU.id}/groups/#{self.id}/join"

  end

  def pending_req_count
    request_count = memberships.where(req: false).count
  end
end
