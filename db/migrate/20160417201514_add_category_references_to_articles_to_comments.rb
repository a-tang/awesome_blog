class AddCategoryReferencesToArticlesToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :category, index: true, foreign_key: true
  end
end
