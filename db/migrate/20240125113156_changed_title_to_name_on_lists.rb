class ChangedTitleToNameOnLists < ActiveRecord::Migration[7.1]
  def change
    change_column :lists, :title, :name
  end
end
