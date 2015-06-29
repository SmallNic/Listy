class AddColumnToLists < ActiveRecord::Migration
  def change
    add_column :lists, :position_x, :string
    add_column :lists, :position_y, :string
  end
end
