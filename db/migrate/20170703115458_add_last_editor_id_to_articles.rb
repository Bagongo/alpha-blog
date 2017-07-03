class AddLastEditorIdToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :last_editor_id, :integer
  end
end
