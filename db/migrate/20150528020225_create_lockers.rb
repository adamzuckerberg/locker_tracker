class CreateLockers < ActiveRecord::Migration
  def change
    create_table :lockers do |t|
      t.string :size
      t.integer :bag_id, default: nil

      t.timestamps null: false
    end
  end
end
