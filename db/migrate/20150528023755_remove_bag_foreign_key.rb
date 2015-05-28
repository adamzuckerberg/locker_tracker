class RemoveBagForeignKey < ActiveRecord::Migration
  def change
    remove_column :lockers, :bag_id
  end
end
