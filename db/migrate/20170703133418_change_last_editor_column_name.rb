class ChangeLastEditorColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :last_editor, :last_editor_name
  end
end
