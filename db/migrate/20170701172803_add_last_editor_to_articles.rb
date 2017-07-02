class AddLastEditorToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :last_editor, :string 
  end
end
