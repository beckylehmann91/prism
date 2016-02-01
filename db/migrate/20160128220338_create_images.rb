class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :post_id
      t.integer :height #in pixels
      t.integer :width #in pixels
      t.string :filename
      t.integer :lum
      t.integer :con
      t.integer :var

      t.timestamps null: false
    end
  end
end
