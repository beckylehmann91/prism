class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.integer :r
      t.integer :g
      t.integer :b
      t.integer :a
      t.integer :image_id

      t.timestamps null: false
    end
  end
end
