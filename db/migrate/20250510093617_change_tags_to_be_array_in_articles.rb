class ChangeTagsToBeArrayInArticles < ActiveRecord::Migration[8.0]
  def change
    remove_column :articles, :tags, :string
    add_column :articles, :tags, :string, array: true, default: []
  end
end
