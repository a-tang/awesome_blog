class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates :body, presence: true
  validates :commenter, presence: true

  def user_full_name
    user ? user.full_name : ""
  end

end
