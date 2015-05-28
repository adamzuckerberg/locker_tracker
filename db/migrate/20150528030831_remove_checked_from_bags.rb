class RemoveCheckedFromBags < ActiveRecord::Migration
  def change
    remove_column :bags, :checked
  end
end
