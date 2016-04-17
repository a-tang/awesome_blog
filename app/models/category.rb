class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :articles, dependent: :nullify
end
