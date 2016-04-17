class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, {presence: true, uniqueness:{message: "must be unique!"}}

  def self.search(search)
    where(["title ILIKE ? OR text ILIKE ?", "%#{search_term}%", "%#{search_term}%"])

end
