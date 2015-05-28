class AddLockerForeignKey < ActiveRecord::Migration
  def change
    add_column :bags, :locker_id, :integer
  end
end
