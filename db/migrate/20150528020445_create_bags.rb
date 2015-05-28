class CreateBags < ActiveRecord::Migration
  def change
    create_table :bags do |t|
      t.string :size

      t.timestamps null: false
    end
  end
end
