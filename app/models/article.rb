class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :category
  validates :title, {presence: true, uniqueness:{message: "must be unique!"}}
  validates :text, {presence: true, uniqueness:{message: "must be unique!"}}

  def self.search(search)
    where("title ILIKE ? OR text ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
