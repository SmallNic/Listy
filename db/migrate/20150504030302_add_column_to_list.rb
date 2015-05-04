class AddColumnToList < ActiveRecord::Migration
  def change
    add_reference :items, :list
  end
end
