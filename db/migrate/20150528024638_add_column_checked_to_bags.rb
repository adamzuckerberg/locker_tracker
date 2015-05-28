class AddColumnCheckedToBags < ActiveRecord::Migration
  def change
    add_column :bags, :checked, :boolean
  end
end
