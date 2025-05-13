class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string :question
      t.text :answer
      t.string :category
      t.text :tags, array: true, default: []

      t.timestamps
    end
  end
end


