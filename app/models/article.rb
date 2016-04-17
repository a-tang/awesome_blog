class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user
  validates :title, {presence: true, uniqueness:{message: "must be unique!"}}
  validates :text, {presence: true, uniqueness:{message: "must be unique!"}}

  def self.search(search)
    where("title ILIKE ? OR text ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def user_full_name
  user ? user.full_name : ""
  end

  private

  def titleize_title
    self.title = title.titleize
  end

end
