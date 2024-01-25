class RenameTitleToNameColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :lists, :title, :name
  end
end
